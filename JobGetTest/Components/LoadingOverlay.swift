//
//  LoadingOverlay.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit
import Combine

final class LoadingOverlay: UIView {
    private let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
    private let activityIndicator = UIActivityIndicatorView.make(started: false)

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        background(.clear)
        blur.constrained()
            .addAsSubview(of: self)
            .centered()
            .dimensions(width: 100, height: 100)
            .rounded()
        activityIndicator.addAndPinAsSubview(of: self)
        isHidden = true
    }
    
    /// Bind the overkay to a `LoadingNotifier`
    /// - Parameters:
    ///   - notifier: The notifier
    ///   - storedIn: The storge bag
    func bindLoadingAnimator(_ notifier: LoadingNotifier, storedIn: inout Set<AnyCancellable>) {
        notifier.isLoading.share()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isLoading in
            guard self?.activityIndicator.isAnimating != isLoading else { return }
            if isLoading {
                self?.isHidden = false
                self?.activityIndicator.startAnimating()
            } else {
                self?.isHidden = true
                self?.activityIndicator.stopAnimating()
            }
        }).store(in: &storedIn)
    }
    
}

