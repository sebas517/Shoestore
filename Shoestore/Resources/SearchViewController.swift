//
//  SearchViewController.swift
//  Shoestore
//
//  Created by dam on 5/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, OnResponse {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //let testArray = ["Spain", "Canada", "Venezuela", "Suiza", "Italia", "Eslovenia", "China", "Australia", "Marruecos", "India"];
    private var categories: [Category] = []
    
    var categoriaId : Int?
    var destinatario: Int?
    var search : String?
    var searching = false
    var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let cliente = RestClient(service: "categoria/",response: self) else {
            return
        }
        cliente.request()
        
        
    }
    
    func onData(data: Data) {
        print(String(data:data,encoding:String.Encoding.utf8)!)
        do {
            let decoder = JSONDecoder()
            let categorias = try decoder.decode(Categorias.self, from:data)
            
            for categoryRest in categorias.categorias {
                categories.append(Category(id: categoryRest.id, name: categoryRest.nombre))
            }
            tableView.reloadData()
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    
    func onDataError(message: String) {
        print(message)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = categories[indexPath.row].getName().uppercased()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoriaId = categories[indexPath.row].getId()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
            case 0:
                let destinatario = 3
            break
            case 1:
                let destinatario = 4
                break
            case 2:
                let destinatario = 2
                break
            case 3:
                let destinatario = 1
                break
            default:
                return
            }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let destinationVC = SearchViewController()
        destinationVC.search = searchBar.text
        
        destinationVC.performSegue(withIdentifier: "searchSegue", sender: self)
    }
}
