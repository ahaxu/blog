---
title: Cardano plutus policyid deserialisation error
author: lk
---

There is a case, when calling `Contract.submitTxConstraints ` in off chain code
```haskell
    ledgerTx <- Contract.submitTxConstraints axuTypeValidator tx
```

it throw this error
```bash
Slot 00001: *** CONTRACT STOPPED WITH ERROR: "\"WalletContractError (ToCardanoError (Tag \\\"toCardanoPolicyId\\\" (Tag \\\"2 bytes\\\" DeserialisationError)))\""
```

the problem is the code from tutorial use `ff` for `CurrencySymbol`

```haskell
gameTokenCurrency :: CurrencySymbol
gameTokenCurrency = "ff"
```

To fix this, we need to use correct serialisation of **policyid** as **CurrencySymbol**
for eg
```haskell
gameTokenCurrency :: CurrencySymbol
gameTokenCurrency = "baa836fef09cb35e180fce4b55ded152907af1e2c840ed5218776aaa"
```

Then, **wuho0o0o!!**, it's work perfectly, with **Emulator**,I can do **lock** a validator script as bellow (logs were substracted)
```bash
...
Slot 00001: W[1]: TxSubmit: 8f6ed8d628d028084ff4d01fa7afc21bbb3911b0ebd037b75870ff16b4052614
Slot 00001: *** CONTRACT LOG: "before calling awaitTxConfirmed"
Slot 00001: TxnValidate 8f6ed8d628d028084ff4d01fa7afc21bbb3911b0ebd037b75870ff16b4052614
Slot 00001: SlotAdd Slot 2
Slot 00002: W[2]: InsertionSuccess: New tip is Tip(Slot 2, BlockId fd32b5f7e47fae4f2b35b27908647c311ad59beba76f3c596b03072c5f07d81b, BlockNumber 1). UTxO state was added to the end.
Slot 00002: W[1]: InsertionSuccess: New tip is Tip(Slot 2, BlockId fd32b5f7e47fae4f2b35b27908647c311ad59beba76f3c596b03072c5f07d81b, BlockNumber 1). UTxO state was added to the end.
Slot 00002: *** CONTRACT LOG: "100 km target set"
...
```

Credit to this great <a href="https://cardano.stackexchange.com/questions/5952/deserialisationerror-when-exporting-unbalancedtx/9025#9025" target="_blank">answer</a> of @Jey on cardano stackexchange. 
