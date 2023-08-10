//
//  TestCell.swift
//  Clone_NaverWebToon
//
//  Created by 김승현 on 2023/08/08.
//

import UIKit

class TopCell: UICollectionViewCell {
    
    weak var parent = FirstViewController()
    
    // MARK: - UIComponents
    let titleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.backgroundColor = .systemBlue
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.contentView.addSubview(titleView)
        setupLayoutForTopCell()
        self.contentView.backgroundColor = .systemGray5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TopCell {
    func setupLayoutForTopCell() {
        self.contentView.addSubview(titleView)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
//        titleView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        titleView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        titleView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        
    }
}
