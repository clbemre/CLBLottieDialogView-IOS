//
//  CLBLottieDialogView.swift
//  LottieDialogView
//
//  Created by Emre Celebi  on 8.03.2019.
//  Copyright © 2019 cLB. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

typealias CLBLottieDialogViewBlock = ((CLBLottieDialogView?) -> Void)?

class CLBLottieDialogView: UIViewController {

    private var buttonHeight: CGFloat = Constants.defaultButtonHeight
    private var configuration: CLBLottieDialogView.Configuration = Configuration()

    private var isAutoDismiss: Bool = true

    var dialogType: DialogType = DialogType.SUCCESS {
        didSet {
            var jsonName = "success.json"
            if dialogType == DialogType.SUCCESS {
                jsonName = "success.json"
            } else if dialogType == DialogType.WARNING {
                jsonName = "warning.json"
            } else if dialogType == DialogType.QUESTION {
                jsonName = "question.json"
            } else if dialogType == DialogType.ERROR {
                jsonName = "error.json"
            } else if dialogType == DialogType.PROGRESS {
                jsonName = "loading.json"
            }
            self.initLottieAnimationView(jsonName: jsonName)
        }
    }

    var dialogTitle: String = "" {
        didSet {
            self.titleLabel.text = dialogTitle
        }
    }

    var dialogMessage: String = "" {
        didSet {
            self.messageLabel.text = self.dialogMessage
        }
    }

    var containerCornerRadius: CGFloat = 2.0 {
        didSet {
            self.containerView.layer.cornerRadius = self.containerCornerRadius
        }
    }

    var isPositiveButton: Bool = false {
        didSet {
            if isPositiveButton {
                self.initPositiveButton()
            }
        }
    }

    var positiveButtonText: String = "" {
        didSet {
            self.positiveButton.setTitle(positiveButtonText, for: .normal)
        }
    }

    var blockPositiveButton: CLBLottieDialogViewBlock = nil

    var isNegativeButton: Bool = false {
        didSet {
            if isNegativeButton {
                self.initNegativeButton()
            }
        }
    }

    var negativeButtonText: String = "" {
        didSet {
            self.negativeButton.setTitle(negativeButtonText, for: .normal)
        }
    }

    var blockNegativeButton: CLBLottieDialogViewBlock = nil

    var isNeutralButton: Bool = false {
        didSet {
            if isNeutralButton {
                self.initNeutralButton()
            }
        }
    }

    var neutralButtonText: String = "" {
        didSet {
            self.neutralButton.setTitle(neutralButtonText, for: .normal)
        }
    }

    var blockNeutralButton: CLBLottieDialogViewBlock = nil

    var loopAnimation: Bool = false {
        didSet {
            animationView?.loopAnimation = self.loopAnimation
        }
    }

    private func initial(dialogTitle: String = "", dialogMessage: String = "", configuration: CLBLottieDialogView.Configuration = Configuration(), dialogType: DialogType = DialogType.SUCCESS, isAutoDismiss: Bool = true) {
        self.dialogTitle = dialogTitle
        self.dialogMessage = dialogMessage
        self.isAutoDismiss = isAutoDismiss
        self.dialogType = dialogType
        self.configuration = configuration
    }

    private func initial(dialogTitle: String = "", dialogMessage: String = "",
                         configuration: CLBLottieDialogView.Configuration = Configuration()
                         , isPositiveButton: Bool, positiveButtonText: String, positiveButtonBlock: CLBLottieDialogViewBlock
                         , isNegativeButton: Bool, negativeButtonText: String, negativeButtonBlock: CLBLottieDialogViewBlock
                         , isNeutralButton: Bool, neutralButtonText: String, neutralButtonBlock: CLBLottieDialogViewBlock
                         , dialogType: DialogType = DialogType.SUCCESS
                         , isAutoDismiss: Bool = true) {

        self.initial(dialogTitle: dialogTitle, dialogMessage: dialogMessage, configuration: configuration, dialogType: dialogType, isAutoDismiss: isAutoDismiss)

        self.isPositiveButton = isPositiveButton
        self.positiveButtonText = positiveButtonText
        self.blockPositiveButton = positiveButtonBlock

        self.isNegativeButton = isNegativeButton
        self.negativeButtonText = negativeButtonText
        self.blockNegativeButton = negativeButtonBlock

        self.isNeutralButton = isNeutralButton
        self.neutralButtonText = neutralButtonText
        self.blockNeutralButton = neutralButtonBlock
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.initView()
    }

    func initView() {
        self.initContainerView()
        self.initCircleTopView()
        self.initDialogTitle()
        self.initDialogMessage()
        self.initStackView()
        self.initConfigurationWithStyle()
    }

    func initContainerView() {
        self.view.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(self.view).offset(-32)
            maker.leading.equalTo(self.view).offset(32)
            maker.center.equalTo(self.view)
            // maker.height.equalTo(self.view.frame.size.height / 3)
        }
    }

    func initCircleTopView() {
        self.view.addSubview(self.circleTopView)
        self.circleTopView.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(self.view.frame.width / Constants.circleViewDivide)
            maker.top.equalTo(self.containerView).offset(-(self.view.frame.width / Constants.circleViewDivide) / 2)
            maker.centerX.equalTo(self.containerView)
        }
        self.circleTopView.layer.cornerRadius = (self.view.frame.width / Constants.circleViewDivide) / 2
    }

    func initLottieAnimationView(jsonName: String) {
        animationView = LOTAnimationView(name: jsonName)
        animationView!.contentMode = .scaleAspectFill
        animationView!.animationSpeed = 0.5
        _ = self.self.circleTopView.subviews.filter { (view) -> Bool in
            view.removeFromSuperview()
            return true
        }
        self.circleTopView.addSubview(animationView!)
        animationView!.snp.makeConstraints { (maker) in
            maker.top.leading.equalTo(self.circleTopView).offset(4.0)
            maker.bottom.trailing.equalTo(self.circleTopView).offset(-4.0)
        }
        animationView!.play()
    }

    func initDialogTitle() {
        let titleLabelTopConstraint = ((self.view.frame.width / Constants.circleViewDivide) / 2) + 8.0
        self.containerView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.containerView).offset(titleLabelTopConstraint)
            maker.leading.equalTo(self.containerView).offset(16.0)
            maker.trailing.equalTo(self.containerView).offset(-16.0)
            maker.height.equalTo(30.0)
        }
    }

    func initDialogMessage() {
        self.containerView.addSubview(self.messageLabel)
        self.messageLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.titleLabel.snp.bottom).offset(8.0)
            maker.leading.equalTo(self.containerView).offset(16.0)
            maker.trailing.equalTo(self.containerView).offset(-16.0)
        }
    }

    func initStackView() {
        if dialogType == DialogType.PROGRESS {
            self.buttonHeight = 0.0
        } else {
            self.buttonHeight = Constants.defaultButtonHeight
        }
        self.containerView.addSubview(self.stackButtonsView)
        self.stackButtonsView.snp.makeConstraints { (maker) in
            maker.width.lessThanOrEqualTo(self.view.frame.size.width - 100.0)
            maker.top.equalTo(self.messageLabel.snp.bottom).offset(32.0)
            maker.height.equalTo(self.buttonHeight)
            maker.centerX.equalTo(self.containerView)
            if isNeutralButton {
                maker.bottom.equalTo(self.neutralButton.snp.top).offset(-8.0)
            } else {
                maker.bottom.equalTo(self.containerView).offset(-16.0)
            }
        }
    }

    func initPositiveButton() {
        self.stackButtonsView.addArrangedSubview(self.positiveButton)
        self.positiveButton.snp.makeConstraints { (maker) in
            maker.width.greaterThanOrEqualTo(100)
        }
        self.positiveButton.addTarget(self, action: #selector(self.actionPositiveButton(sender:)), for: .touchUpInside)
    }

    func initNegativeButton() {
        self.stackButtonsView.addArrangedSubview(self.negativeButton)
        self.negativeButton.snp.makeConstraints { (maker) in
            maker.width.greaterThanOrEqualTo(100)
        }
        self.negativeButton.addTarget(self, action: #selector(self.actionNegativeButton(sender:)), for: .touchUpInside)
    }

    func initNeutralButton() {
        self.containerView.addSubview(self.neutralButton)
        self.neutralButton.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(self.containerView).offset(-16.0)
            maker.centerX.equalTo(self.containerView)
            maker.height.equalTo(self.buttonHeight)
            maker.width.greaterThanOrEqualTo(100)
            maker.width.lessThanOrEqualTo(self.view.frame.size.width - 100.0)
        }
        self.neutralButton.addTarget(self, action: #selector(self.actionNeutralButton(sender:)), for: .touchUpInside)
    }

    func initConfigurationWithStyle() {
        self.containerView.layer.cornerRadius = self.configuration.containerCornerRadius
        self.containerView.backgroundColor = self.configuration.backgroundColor
        self.circleTopView.backgroundColor = self.configuration.backgroundColor
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: self.configuration.titleSize)
        self.titleLabel.textColor = self.configuration.titleColor
        self.messageLabel.font = UIFont.systemFont(ofSize: self.configuration.messageSize)
        self.messageLabel.textColor = self.configuration.messageColor
        self.animationView?.loopAnimation = self.configuration.loonAnimation
    }

    func hide() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func actionPositiveButton(sender: UIButton!) {
        self.blockPositiveButton?(self)
        if isAutoDismiss {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc func actionNegativeButton(sender: UIButton!) {
        self.blockNegativeButton?(self)
        if isAutoDismiss {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc func actionNeutralButton(sender: UIButton!) {
        self.blockNeutralButton?(self)
        if isAutoDismiss {
            self.dismiss(animated: true, completion: nil)
        }
    }

    var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.defaultShadow()
        return view
    }()

    let circleTopView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.defaultShadow()
        return view
    }()

    var animationView: LOTAnimationView? = nil

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = NSTextAlignment.center
        return label
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = NSTextAlignment.center
        return label
    }()

    let stackButtonsView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        return stackView
    }()

    let positiveButton: UIButton = {
        let button = Utils.createUIButton()
        return button
    }()

    let negativeButton: UIButton = {
        let button = Utils.createUIButton()
        return button
    }()

    let neutralButton: UIButton = {
        let button = Utils.createUIButton()
        return button
    }()

    enum DialogType: Int {
        case SUCCESS = 0
        case QUESTION = 1
        case WARNING = 2
        case ERROR = 3
        case PROGRESS = 4
    }

    class Configuration {
        var titleSize: CGFloat = 20.0
        var messageSize: CGFloat = 13.0
        var titleColor: UIColor = UIColor.darkGray
        var messageColor: UIColor = UIColor.darkGray
        var backgroundColor: UIColor = UIColor.white
        var containerCornerRadius: CGFloat = 20.0
        var loonAnimation: Bool = true
    }

    class Builder {

        private var viewController: UIViewController? = nil
        private var alertDialog: CLBLottieDialogView? = nil

        private var dialogTitle: String = ""
        private var dialogMessage: String = ""
        private var dialogLoopAnimation: Bool = false
        private var backgroundColor = UIColor.white
        private var containerCornerRadius: CGFloat = 10.0

        private var isPositiveButton = false
        private var positiveButtonText = ""
        private var blockPositiveButton: CLBLottieDialogViewBlock = nil

        private var isNegativeButton = false
        private var negativeButtonText = ""
        private var blockNegativeButton: CLBLottieDialogViewBlock = nil

        private var isNeutralButton = false
        private var neutralButtonText = ""
        private var blockNeutralButton: CLBLottieDialogViewBlock = nil

        private var configuration: CLBLottieDialogView.Configuration = Configuration()

        init(viewController: UIViewController) {
            self.viewController = viewController
            self.alertDialog = CLBLottieDialogView()
            self.alertDialog?.modalTransitionStyle = .crossDissolve
            self.alertDialog?.modalPresentationStyle = .overCurrentContext
        }

        func withTitle(title: String) -> Builder {
            self.dialogTitle = title
            return self
        }

        func withMessage(message: String) -> Builder {
            self.dialogMessage = message
            return self
        }

        func withPositiveButton(title: String?, block: CLBLottieDialogViewBlock = nil) -> Builder {
            if let title = title {
                self.isPositiveButton = true
                self.positiveButtonText = title
                self.blockPositiveButton = block
            }
            return self
        }

        func withNegativeButton(title: String?, block: CLBLottieDialogViewBlock = nil) -> Builder {
            if let title = title {
                self.isNegativeButton = true
                self.negativeButtonText = title
                self.blockNegativeButton = block
            }
            return self
        }

        func withNeutralButton(title: String?, block: CLBLottieDialogViewBlock = nil) -> Builder {
            if let title = title {
                self.isNeutralButton = true
                self.neutralButtonText = title
                self.blockNeutralButton = block
            }
            return self
        }

        func withConfituration(configuration: CLBLottieDialogView.Configuration = Configuration()) -> Builder {
            self.configuration = configuration
            return self
        }

        func show(dialogType: DialogType = DialogType.SUCCESS, isAutoDismiss: Bool = true) {
            if dialogType == DialogType.PROGRESS {
                self.alertDialog?.initial(dialogTitle: dialogTitle, dialogMessage: dialogMessage, configuration: configuration, dialogType: .PROGRESS)
            } else {
                self.alertDialog?.initial(dialogTitle: dialogTitle, dialogMessage: dialogMessage, configuration: configuration, isPositiveButton: isPositiveButton, positiveButtonText: positiveButtonText, positiveButtonBlock: blockPositiveButton, isNegativeButton: isNegativeButton, negativeButtonText: negativeButtonText, negativeButtonBlock: blockNegativeButton, isNeutralButton: isNeutralButton, neutralButtonText: neutralButtonText, neutralButtonBlock: blockNegativeButton, dialogType: dialogType, isAutoDismiss: isAutoDismiss)
            }
            UIView.animate(withDuration: 0.5) {
                self.viewController?.present(self.alertDialog!, animated: true, completion: nil)
            }
        }

        func showProgress() {
            self.alertDialog?.initial(dialogTitle: dialogTitle, dialogMessage: dialogMessage, configuration: configuration, dialogType: .PROGRESS)
            UIView.animate(withDuration: 0.5) {
                self.viewController?.present(self.alertDialog!, animated: true, completion: nil)
            }
        }

        func hideDialog() {
            self.alertDialog?.dismiss(animated: true, completion: nil)
        }
    }
}

extension CLBLottieDialogView.Builder {
    static func successDialog(_ viewController: UIViewController, configuration: CLBLottieDialogView.Configuration = CLBLottieDialogView.Configuration(), dialogTitle: String = "Success!", dialogMessage: String
                              , positiveButtonText: String = "OK", blockPositive: CLBLottieDialogViewBlock = nil
                              , negativeButtonText: String? = nil, blockNegative: CLBLottieDialogViewBlock = nil
                              , neutralButtonText: String? = nil, blockNeutral: CLBLottieDialogViewBlock = nil) {
        let builder = CLBLottieDialogView.Builder(viewController: viewController)
            .withTitle(title: dialogTitle)
            .withMessage(message: dialogMessage)
            .withNeutralButton(title: neutralButtonText, block: blockNeutral)
            .withNegativeButton(title: negativeButtonText, block: blockNegative)
            .withPositiveButton(title: positiveButtonText, block: blockPositive)
            .withConfituration(configuration: configuration)
        builder.show(dialogType: CLBLottieDialogView.DialogType.SUCCESS, isAutoDismiss: true)
    }

    static func warningDialog(_ viewController: UIViewController, configuration: CLBLottieDialogView.Configuration = CLBLottieDialogView.Configuration(), dialogTitle: String = "Warning!", dialogMessage: String
                              , positiveButtonText: String = "OK", blockPositive: CLBLottieDialogViewBlock = nil
                              , negativeButtonText: String? = nil, blockNegative: CLBLottieDialogViewBlock = nil
                              , neutralButtonText: String? = nil, blockNeutral: CLBLottieDialogViewBlock = nil) {
        let builder = CLBLottieDialogView.Builder(viewController: viewController)
            .withTitle(title: dialogTitle)
            .withMessage(message: dialogMessage)
            .withNeutralButton(title: neutralButtonText, block: blockNeutral)
            .withNegativeButton(title: negativeButtonText, block: blockNegative)
            .withPositiveButton(title: positiveButtonText, block: blockPositive)
            .withConfituration(configuration: configuration)
        builder.show(dialogType: CLBLottieDialogView.DialogType.WARNING, isAutoDismiss: true)
    }

    static func questionDialog(_ viewController: UIViewController, configuration: CLBLottieDialogView.Configuration = CLBLottieDialogView.Configuration(), dialogTitle: String = "Question!", dialogMessage: String
                               , positiveButtonText: String = "OK", blockPositive: CLBLottieDialogViewBlock = nil
                               , negativeButtonText: String? = nil, blockNegative: CLBLottieDialogViewBlock = nil
                               , neutralButtonText: String? = nil, blockNeutral: CLBLottieDialogViewBlock = nil) {
        let builder = CLBLottieDialogView.Builder(viewController: viewController)
            .withTitle(title: dialogTitle)
            .withMessage(message: dialogMessage)
            .withNeutralButton(title: neutralButtonText, block: blockNeutral)
            .withNegativeButton(title: negativeButtonText, block: blockNegative)
            .withPositiveButton(title: positiveButtonText, block: blockPositive)
            .withConfituration(configuration: configuration)
        builder.show(dialogType: CLBLottieDialogView.DialogType.QUESTION, isAutoDismiss: true)
    }

    static func errorDialog(_ viewController: UIViewController, configuration: CLBLottieDialogView.Configuration = CLBLottieDialogView.Configuration(), dialogTitle: String = "Error!", dialogMessage: String
                            , positiveButtonText: String = "OK", blockPositive: CLBLottieDialogViewBlock = nil
                            , negativeButtonText: String? = nil, blockNegative: CLBLottieDialogViewBlock = nil
                            , neutralButtonText: String? = nil, blockNeutral: CLBLottieDialogViewBlock = nil) {
        let builder = CLBLottieDialogView.Builder(viewController: viewController)
            .withTitle(title: dialogTitle)
            .withMessage(message: dialogMessage)
            .withNeutralButton(title: neutralButtonText, block: blockNeutral)
            .withNegativeButton(title: negativeButtonText, block: blockNegative)
            .withPositiveButton(title: positiveButtonText, block: blockPositive)
            .withConfituration(configuration: configuration)
        builder.show(dialogType: CLBLottieDialogView.DialogType.ERROR, isAutoDismiss: true)
    }

    static func progressDialog(_ viewController: UIViewController, configuration: CLBLottieDialogView.Configuration = CLBLottieDialogView.Configuration(), dialogTitle: String = "Please Wait..", dialogMessage: String) -> CLBLottieDialogView.Builder {
        let builder = CLBLottieDialogView.Builder(viewController: viewController)
            .withTitle(title: dialogTitle)
            .withMessage(message: dialogMessage)
            .withConfituration(configuration: configuration)
        return builder
    }
}
