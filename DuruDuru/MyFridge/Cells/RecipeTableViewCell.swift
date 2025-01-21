//
//  RecipeTableViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/13/25.
//

import UIKit

class RecipeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Init
    
    static let identifier: String = "recipeTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .default
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        selectionStyle = .none
        addComponents()
        constraints()
        setBasicTag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleImage.image = nil
        self.recipeName.text = nil
    }
    
    // MARK: - Components
    
    /// 대표 이미지
    let titleImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    let container = UIView().then {
        $0.layer.cornerRadius = 12
    }
    
    /// 좋아요 버튼
    let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "Heart"), for: .normal)
    }
    
    /// 레시피 이름
    let recipeName = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
    }
    
    let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 8 // 좌우 간격
        $0.estimatedItemSize = .init(width: 45, height: 22)// 셀 크기
    }).then {
        $0.backgroundColor = .clear
        $0.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    /// 구분 선
    let dividedLine = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xDCDCDC, alpha: 1.0)
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(container)
        addSubview(recipeName)
        addSubview(tagCollectionView)
        container.addSubview(titleImage)
        container.addSubview(likeButton)
        addSubview(dividedLine)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        container.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalTo(370)
            $0.height.equalTo(158.57)
        }
        
        titleImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-11.6)
            $0.width.height.equalTo(20)
        }
        
        recipeName.snp.makeConstraints {
            $0.top.equalTo(container.snp.bottom).offset(12)
            $0.left.equalToSuperview()
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(recipeName.snp.bottom).offset(2)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        dividedLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(tagCollectionView.snp.bottom).offset(23)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            
        }
    }
    
    let tagList = ["쿠앤크","메로나","아몬드 빼빼로","콘칩","나쵸","꼬깔콘","빙그레 바나나","액셀런트","더위사냥","꿀꽈배기","버터와플","새우칩","스프링클","하리보","새콤달콤","푸딩","에이스","홈런볼","바밤바","허쉬","ABC 초콜릿"]
    
    var tagOnOffArray: [Bool] = []
    
    func setBasicTag(){
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        self.createBtnArray()
    }
    
    // Tag 갯수 만큼 제작
    func createBtnArray() {
        for _ in 0..<self.tagList.count {
            self.tagOnOffArray.append(false)
        }
    }
    
    // MARK: 콜렉션 뷰 데이터
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
        cell.configure(tag: tagList[indexPath.row])
        return cell
    }
    
    func getClickList() -> String {
        var result: String = ""
        for i in 0..<self.tagList.count {
            if self.tagOnOffArray[i] {
                result += (" " + self.tagList[i])
            }
        }
        return result
    }
    
}
