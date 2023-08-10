//
//  WeekCell.swift
//  Clone_NaverWebToon
//
//  Created by 김승현 on 2023/08/10.
//

import UIKit

class WeekCell: UICollectionViewCell {
    
    weak var parent = FirstViewController()

    // MARK: - UIComponents
    lazy var eachCellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
//        label.backgroundColor = .black
        return label
    }()
    
    lazy var underBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(eachCellLabel)
        self.contentView.addSubview(underBarView)
        setupLayoutForWeekCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WeekCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                eachCellLabel.textColor = .systemGreen
                underBarView.backgroundColor = .systemGreen
                
//                switch eachCellLabel.text {
//                case "토", "일", "완결":
//                    print("토일완결")
//                default:
//                    print("nothing")
//                    print(eachCellLabel.text)
//                    break
//                }
            }
            else {
                eachCellLabel.textColor = .white
                underBarView.backgroundColor = .clear
            }
        }
    }
    
    func setupLayoutForWeekCell() {
        eachCellLabel.translatesAutoresizingMaskIntoConstraints = false
        eachCellLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        eachCellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        eachCellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        eachCellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4).isActive = true
        
        underBarView.translatesAutoresizingMaskIntoConstraints = false
        underBarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        underBarView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        underBarView.topAnchor.constraint(equalTo: eachCellLabel.bottomAnchor).isActive = true
        underBarView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}
