import UIKit

class ViewController: UIViewController {

    private var data: [Data] = {
        var array = [Data]()
        for i in 0...20 {
            array.append(Data(number: i, check: false))
        }
        return array
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = UITableView.automaticDimension
        table.delegate = self
        table.dataSource = self
        table.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCellID")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mixed Table"
        self.view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector(shuffleAction))
        self.view.addSubview(tableView)

        // Constraints
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }

    @objc
    private func shuffleAction() {
        tableView.performBatchUpdates({ [weak self] in
            data.shuffle()
            tableView.reloadSections(IndexSet(integer: 0), with: .bottom)
        })
    }
}



// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)
        if cell?.accessoryType != .checkmark {
            cell?.accessoryType = .checkmark
            data[indexPath.row].check = true
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
            data.insert(data[indexPath.row], at: 0)
            data.remove(at: indexPath.row + 1)
        } else {
            cell?.accessoryType = .none
            data[indexPath.row].check = false
            tableView.deselectRow(at: indexPath, animated: true)

        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellID", for: indexPath) as? TableViewCell else { fatalError("could not dequeueReusableCell") }
        cell.updateCell(data[indexPath.row])

        if let selectedRows = tableView.indexPathsForSelectedRows, selectedRows.contains(indexPath) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        if data[indexPath.row].check == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}
