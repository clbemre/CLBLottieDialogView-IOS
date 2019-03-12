//
//  ViewController.swift
//  LottieDialogView
//
//  Created by Emre Celebi  on 8.03.2019.
//  Copyright © 2019 cLB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let builder = CLBLottieDialogView.Builder.progressDialog(self, dialogMessage: "Message")
            builder.showProgress()

            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                builder.hideDialog()
            })
        }
    }

    @IBAction func OpenAlert(_ sender: UIButton) {
        let config = CLBLottieDialogView.Configuration()
        config.backgroundColor = UIColor.red
        config.titleColor = UIColor.white
        config.titleSize = 32.0
        config.containerCornerRadius = 2.0
        
        CLBLottieDialogView.Builder.successDialog(self, configuration: config, dialogMessage: "Message", positiveButtonText: "OK", blockPositive: { (dialog) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                CLBLottieDialogView.Builder.warningDialog(self, dialogMessage: "Message", positiveButtonText: "OK", blockPositive: { (dialog) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        CLBLottieDialogView.Builder.questionDialog(self, dialogMessage: "Message", positiveButtonText: "OK", blockPositive: { (dialog) in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                CLBLottieDialogView.Builder.errorDialog(self, dialogMessage: "Message", positiveButtonText: "OK", blockPositive: { (dialog) in

                                })
                            }
                        })
                    }
                })
            }
        })
    }

}

