//
//  CalorieSearchViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/11.
//

import Alamofire
import UIKit

class CalorieSearchViewController: UITableViewController {
    var searchController: UISearchController!
    var products: [CalorieSearchResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calorie Search"
        setupSearchController()
        setupTableView()
    }

    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func searchProducts(for query: String) {
        let urlString = "https://food-calorie-data-search.p.rapidapi.com/api/search?keyword=\(query)"
        guard let url = URL(string: urlString) else {
            showAlertController(title: "Error", message: "Invalid URL")
            return
        }

        let headers = HTTPHeaders([
            "x-rapidapi-host": "food-calorie-data-search.p.rapidapi.com",
            "x-rapidapi-key": "32fa0b2208mshf5f0a458abd503cp1f2368jsnf3a9dca45949"
        ])


        AF.request(url, headers: headers).responseDecodable(of: [CalorieSearchResult].self) { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case .success(let res):
                strongSelf.products = res
                strongSelf.tableView.reloadData()
            case .failure(let error):
                strongSelf.showAlertController(title: "Error", message: error.errorDescription ?? "Something went wrong")
                return
            }
        }
    }

    private func showAlertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}

extension CalorieSearchViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = products[indexPath.row].shrt_desc
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        let product = products[indexPath.row]
        let text = """
        kCalorie: \(product.energ_kcal)
        Protein: \(product.protein)
        Lipid: \(product.lipid_tot)
        Carbohydrate: \(product.carbohydrt)
        Fiber: \(product.fiber_td)
        Sugar: \(product.sugar_tot)
        Calcium: \(product.calcium)
        Iron: \(product.iron)
        Magnesium: \(product.magnesium)
        Phosphorus: \(product.phosphorus)
        Potassium: \(product.potassium)
        Sodium: \(product.sodium)
        """
        showAlertController(title: product.shrt_desc, message: text)
    }
}

extension CalorieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchProducts(for: text)
    }
}
