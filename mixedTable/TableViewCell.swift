import UIKit

class TableViewCell: UITableViewCell {

    private var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(numberLabel)

        // Constraints
        numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        numberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        numberLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCell(_ model: Data) {
        numberLabel.text = String(model.number)
    }
}
