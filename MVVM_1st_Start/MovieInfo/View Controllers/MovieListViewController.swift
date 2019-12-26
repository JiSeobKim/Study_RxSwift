//
//  MovieListViewController.swift
//  MovieInfo
//
//  Created by Alfian Losari on 10/03/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var movieListViewViewModel: MovieListViewViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Changed
        self.movieListViewViewModel = MovieListViewViewModel(
            endpoint: segmentedControl.rx.selectedSegmentIndex
                .map{Endpoint(index: $0) ?? .nowPlaying}
                .asDriver(onErrorJustReturn: .nowPlaying),
            movieService: MovieStore.shared)
        
        movieListViewViewModel.movies.drive(onNext: {[unowned self] (_) in
             self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        movieListViewViewModel
        .isFetching
        .drive(activityIndicatorView.rx.isAnimating)
        .disposed(by: disposeBag)
        
        movieListViewViewModel
              .error
              .drive(onNext: {[unowned self] (error) in
                   self.infoLabel.isHidden = !self.movieListViewViewModel.hasError
                    self.infoLabel.text = error
               }).disposed(by: disposeBag)
        
          setupTableView()
        
        // MARK: - START
//        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
//        setupTableView()
//        fetchMovies()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MARK: - Changed
        return self.movieListViewViewModel.numberOfMovies
        
        // MARK: - START
//        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: -Changed
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if let item = self.movieListViewViewModel.viewModelForMovie(at: indexPath.row) {
            cell.configure(viewModel: item)
        }
        return cell
        
        // MARK: -START
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
//        let movie = movies[indexPath.row]
//
//
//        cell.titleLabel.text = movie.title
//        cell.releaseDateLabel.text = dateFormatter.string(from: movie.releaseDate)
//        cell.overviewLabel.text = movie.overview
//        cell.posterImageView.kf.setImage(with: movie.posterURL)
//
//        let rating = Int(movie.voteAverage)
//        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
//            return acc + "⭐️"
//        }
//        cell.ratingLabel.text = ratingText
//
//        return cell
    }
}
