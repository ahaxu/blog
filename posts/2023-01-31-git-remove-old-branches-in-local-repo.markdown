---
title: (En) Git - remove old branches in local repo
description: Git - remove old branches in local repo
author: lk
tags: git
keywords: git
---

## Git 101 - Remove old branches in local repo

```
git for-each-ref \
    --sort=committerdate \
    --format=' %(authordate:relative)%09%(refname:short)' refs/heads \
    | grep -E "year|month" \
    | awk '{print $NF}' \
    | xargs -I$ git branch -D $
```

Key commands:

- git for-each-ref
- awk
- xargs

## Ref

- [`git for-each-ref`](https://git-scm.com/docs/git-for-each-ref)

## Link to youtube video

- [Linux 101 - git remove old branches in local repo](https://youtu.be/uFi6FrDlSS8)
