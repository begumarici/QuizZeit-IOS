import UIKit

class WordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!

    var words: [String: String] = [:]
    var filteredWords: [String: String] = [:]
    var sectionedWords: [String: [String]] = [:]
    var sectionTitles: [String] = []
    var isSearching: Bool = false
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()

        words = loadWords()
        let wordKeys = Array(words.keys).sorted()

        for key in wordKeys {
            let firstLetter = String(key.prefix(1)).uppercased()
            if sectionedWords[firstLetter] == nil {
                sectionedWords[firstLetter] = []
            }
            sectionedWords[firstLetter]?.append(key)
        }

        sectionTitles = Array(sectionedWords.keys).sorted()

        tableView.dataSource = self
        tableView.delegate = self
        setupSearchController()
    }

    func loadWords() -> [String: String] {
        if let url = Bundle.main.url(forResource: "B1", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let words = try JSONDecoder().decode([String: String].self, from: data)
                return words
            } catch {
                print("JSON read error: \(error)")
            }
        }
        return [:]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? 1 : sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredWords.count
        } else {
            let sectionKey = sectionTitles[section]
            return sectionedWords[sectionKey]?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)

        if isSearching {
            let keys = Array(filteredWords.keys).sorted()
            let key = keys[indexPath.row]
            cell.textLabel?.text = key
            cell.detailTextLabel?.text = filteredWords[key]
        } else {
            let sectionKey = sectionTitles[indexPath.section]
            if let wordsInSection = sectionedWords[sectionKey] {
                let word = wordsInSection[indexPath.row]
                cell.textLabel?.text = word
                cell.detailTextLabel?.text = words[word]
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isSearching ? nil : sectionTitles[section]
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return isSearching ? nil : sectionTitles
    }

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionTitles.firstIndex(of: title) ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord: String
        let translation: String?

        if isSearching {
            let keys = Array(filteredWords.keys).sorted()
            selectedWord = keys[indexPath.row]
            translation = filteredWords[selectedWord]
        } else {
            let sectionKey = sectionTitles[indexPath.section]
            if let wordsInSection = sectionedWords[sectionKey] {
                selectedWord = wordsInSection[indexPath.row]
                translation = words[selectedWord]
            } else {
                return
            }
        }

        let alert = UIAlertController(
            title: selectedWord,
            message: translation ?? "No translation available",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search in German or English"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            filteredWords = [:]
            tableView.reloadData()
            return
        }

        isSearching = true
        filteredWords = words.filter { key, value in
            key.lowercased().contains(searchText.lowercased()) ||
            value.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
