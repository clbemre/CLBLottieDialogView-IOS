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

            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000), execute: {
                builder.hideDialog()
            })
        }
    }

    @IBAction func OpenAlert(_ sender: UIButton) {
        CLBLottieDialogView.Builder.successDialog(self, dialogMessage: "Message", positiveButtonText: "Tamam", blockPositive: { (dialog) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                CLBLottieDialogView.Builder.warningDialog(self, dialogMessage: "Message", positiveButtonText: "Tamam", blockPositive: { (dialog) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        CLBLottieDialogView.Builder.questionDialog(self, dialogMessage: "Message", positiveButtonText: "Tamam", blockPositive: { (dialog) in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                CLBLottieDialogView.Builder.errorDialog(self, dialogMessage: "Message", positiveButtonText: "Tamam", blockPositive: { (dialog) in

                                })
                            }
                        })
                    }
                })
            }
        })
    }

}

