{-# LANGUAGE OverloadedStrings #-}

import           Data.Monoid
import           Hakyll
import           Sitemap
import           Data.List (isInfixOf)


config :: Configuration
config = defaultConfiguration
    { destinationDirectory = "docs"
    }

sitemapConfig :: SitemapConfiguration
sitemapConfig = def {
    sitemapBase     = "https://ahaxu.com/"
}


main :: IO ()
main = hakyllWith config $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    -- build up tags (excluding private posts)
    tags <- buildTags "posts/*" (fromCapture "tags/*.html")
    tagsRules tags $ \tag pattern -> do
      let title =
            if tag == "thơ thẩn"
            then "Tập tành thơ thẩn, thẩn thơ "
            else "Posts with tag \"" <> tag <> "\""

      route idRoute
      compile $ do
          posts <- recentFirst =<< loadAll pattern
          filteredPosts <- filterPrivatePosts posts
          let ctx =
                constField "title" title <>
                listField "posts" postCtx (return filteredPosts) <>
                defaultContext

          makeItem ""
              >>= loadAndApplyTemplate "templates/tag.html" ctx
              >>= loadAndApplyTemplate "templates/default.html" ctx
              >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    (postCtxWithTags tags)
            >>= loadAndApplyTemplate "templates/default.html" (postCtxWithTags tags)
            >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            filteredPosts <- filterPrivatePosts posts
            let archiveCtx =
                    listField "posts" postCtx (return filteredPosts) <>
                    constField "title" "Archives"            <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    -- gen sitemap.xml
    create ["sitemap.xml"] $ do
        route   idRoute
        compile $ generateSitemap sitemapConfig

    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            filteredPosts <- filterPrivatePosts posts
            let indexCtx =
                    listField "posts" postCtx (return filteredPosts) <>
                    constField "title" "Home"                <>
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateCompiler

    mapM_ static ["humans.txt", "robots.txt"]



postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" <>
    defaultContext

postCtxWithTags :: Tags -> Context String
postCtxWithTags tags = tagsField "tags" tags <> postCtx


static :: Pattern -> Rules ()
static f = match f $ do
    route   idRoute
    compile copyFileCompiler

directory :: (Pattern -> Rules a) -> String -> Rules a
directory act f = act $ fromGlob $ f ++ "/**"

-- Filter out posts with "private" tags
filterPrivatePosts :: [Item String] -> Compiler [Item String]
filterPrivatePosts posts = do
    filtered <- mapM checkPost posts
    return $ concat filtered
  where
    checkPost item = do
        metadata <- getMetadata (itemIdentifier item)
        case lookupString "tags" metadata of
            Just tags | "private" `isInfixOf` tags -> return []
            _ -> return [item]
