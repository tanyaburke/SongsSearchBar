//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
   enum SearchBarScope {
        case artist
        case title
    }
        
        var songs = [Song](){
            didSet{
                tableView.reloadData()
            }
        }
        
        var currentScope = SearchBarScope.artist
        
        var query = ""{
            didSet{
                
                switch currentScope {
                case .artist:
                    songs = Song.loveSongs.filter{$0.artist.lowercased().contains(query.lowercased())}
                case .title:
                    songs = Song.loveSongs.filter{$0.name.lowercased().contains(query.lowercased())}
                
                }
                if songs.isEmpty{
                    songs.append(Song(name: "not found", artist: ""))
                    searchBar.resignFirstResponder()
                }
            }
        }
        

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            loadData()
            tableView.dataSource = self
            searchBar.delegate = self
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let detailViewController = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("failed to segue to DetailViewController")
            }
            let song = songs[indexPath.row]
            detailViewController.song = song
        }
        
        func loadData(){
            songs = Song.loveSongs
        }
        
    }

    extension ViewController:UISearchBarDelegate{
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard !searchText.isEmpty else {
                //searchText is empty here so we get back all the original headlines using our loadData method
                loadData()
                return
            }
            query = searchText
        }
        
        func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            switch selectedScope {
            case 0:
                currentScope = .artist
            case 1:
                currentScope = .title
            default:
                print("no valid search scope")
            }
        }
    }

    extension ViewController:UITableViewDataSource{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return songs.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
            let song = songs[indexPath.row]
            
            cell.textLabel?.text = song.name
            cell.detailTextLabel?.text = song.artist
            
            return cell
        }
    }
