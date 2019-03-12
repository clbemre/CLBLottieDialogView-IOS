# CLBLottieDialogView-IOS
This repository provides a alert dialog view with lottie customization.

### For Android
See [LottieAlertDialog](https://github.com/mayuce/LottieAlertDialog/blob/master/readme.adoc)

### Requirements
```
pod 'lottie-ios'
pod 'SnapKit', '~> 4.0.0'
```

### Manuel Install
Copy the files to your project.
```
CLBLottieDialogView.swift
Utils.swift
animJSON/success.json
animJSON/warning.json
animJSON/question.json
animJSON/error.json
animJSON/loading.json
```

### Usage Dialog
You may follow the source code to see how it works.
```
let builder = CLBLottieDialogView.Builder(viewController: viewController)
            .withTitle(title: dialogTitle)
            .withMessage(message: dialogMessage)
            .setBackgroundColor(color: UIColor.white)
            .setLoopAnimation(bool: true)
            .setCornerRadius(radius: 10.0)
            .withNeutralButton(title: neutralButtonText, block: blockNeutral)
            .withNegativeButton(title: negativeButtonText, block: blockNegative)
            .withPositiveButton(title: positiveButtonText, block: blockPositive)
builder.show(dialogType: CLBLottieDialogView.DialogType.SUCCESS, isAutoDismiss: true)
```
### OR use extension
```
CLBLottieDialogView.Builder.successDialog(self, dialogMessage: "Message", positiveButtonText: "OK"
, blockPositive: { (dialog) in
            // Positive Block
})
```

### Usage Progress View
```
 let builder = CLBLottieDialogView.Builder.progressDialog(self, dialogMessage: "Message")
 builder.showProgress()
 // builder.hideDialog()

```

## Licence
```
MIT License

Copyright (c) 2019 Emre CELEBI

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
