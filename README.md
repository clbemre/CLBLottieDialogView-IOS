# CLBLottieDialogView-IOS
This repository provides a alert dialog view with lottie customization.

[Screen Shot Dialog View](https://github.com/clbemre/CLBLottieDialogView-IOS/blob/master/LottieDialogView/ScreenShot/DialogView.png)

[Screen Shot Progress View](https://github.com/clbemre/CLBLottieDialogView-IOS/blob/master/LottieDialogView/ScreenShot/ProgressView.png)

### For Android
See [LottieAlertDialog](https://github.com/mayuce/LottieAlertDialog/blob/master/readme.adoc)

### Requirements Library
```
pod 'lottie-ios'
pod 'SnapKit', '~> 4.0.0'
```

### Manuel Install
Copy the files to your project.
```swift
CLBLottieDialogView.swift
Utils.swift
Constants.swift
UIView+Extensions.swift
animJSON/success.json
animJSON/warning.json
animJSON/question.json
animJSON/error.json
animJSON/loading.json
so all files
```

### Usage Dialog
You may follow the source code to see how it works.
```swift
let config = CLBLottieDialogView.Configuration()
        config.backgroundColor = UIColor.red
        config.titleColor = UIColor.white
        config.titleSize = 32.0
        config.containerCornerRadius = 2.0
        ...
        
let builder = CLBLottieDialogView.Builder(viewController: viewController)
            .withTitle(title: dialogTitle)
            .withMessage(message: dialogMessage)
            .withNeutralButton(title: neutralButtonText, block: blockNeutral)
            .withNegativeButton(title: negativeButtonText, block: blockNegative)
            .withPositiveButton(title: positiveButtonText, block: blockPositive)
            .withConfituration(configuration: configuration) // optional
builder.show(dialogType: CLBLottieDialogView.DialogType.SUCCESS, isAutoDismiss: true)
```
### OR use extension
```swift
CLBLottieDialogView.Builder.successDialog(self, dialogMessage: "Message", positiveButtonText: "OK"
, blockPositive: { (dialog) in
            // Positive Block
})
```

### Usage Progress View
```swift
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
