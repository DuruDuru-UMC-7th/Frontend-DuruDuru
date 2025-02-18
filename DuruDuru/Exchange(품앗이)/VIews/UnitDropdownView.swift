//
//  UnitDropdownView.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/9/25.
//

import UIKit

import UIKit

import UIKit

class UnitDropdownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private let units = ["단", "컵", "개", "봉지", "kg", "g", "리터"]
    var didSelectUnit: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        // 테두리 설정
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: 0x70737C, alpha: 0.52).cgColor
        clipsToBounds = true
        
        // 아래쪽 코너만 둥글게 설정
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.masksToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "unitCell")
        
        // 구분선 없애기
        tableView.separatorStyle = .none
        
        addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return units.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unitCell", for: indexPath)
        cell.textLabel?.text = units[indexPath.row]
        
        // 텍스트 크기 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUnit = units[indexPath.row]
        didSelectUnit?(selectedUnit)
        removeFromSuperview()
    }
}

