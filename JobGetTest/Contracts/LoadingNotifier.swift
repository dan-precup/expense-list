//
//  LoadingNotifier.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Combine
import Foundation

protocol LoadingNotifier {

    /// Flag to notify the loading state
    var isLoading: CurrentValueSubject<Bool, Never> { get }
}
