import UIKit

class CheckButton: UIButton {
    
    // 현재 상태를 나타내는 플래그 (외부에서 읽기 가능, 내부에서만 쓰기 가능)
    public private(set) var isChecked = false
    
    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 버튼의 초기 설정
    private func configureButton() {
        self.setImage(UIImage(named: "Btn_Unchecked"), for: .normal) // A 이미지 설정
        self.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
    }
    
    // 버튼 클릭 시 상태 전환
    @objc private func toggleCheck() {
        isChecked.toggle() // 상태 변경
        updateImage()
    }
    
    // 외부에서 상태를 변경할 수 있도록 메서드 추가
    public func setCheckState(to checked: Bool) {
        self.isChecked = checked
        updateImage() // 이미지 갱신
    }
    
    // 이미지 업데이트 메서드
    private func updateImage() {
        let imageName = isChecked ? "Btn_Checked" : "Btn_Unchecked"
        self.setImage(UIImage(named: imageName), for: .normal)
    }
}
