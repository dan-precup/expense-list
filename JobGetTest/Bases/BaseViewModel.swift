//
//  BaseViewModel.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Combine
import Foundation

class BaseViewModel: LoadingNotifier {
    
    /// The loading notifier
    let isLoading = CurrentValueSubject<Bool, Never>(false)
    
    /// The cancellable bag
    var bag = Set<AnyCancellable>()
}

