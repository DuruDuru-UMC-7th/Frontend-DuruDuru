//
//  CustomCameraViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/31/25.
//

import UIKit
import AVFoundation

class CustomCameraViewController: UIViewController {
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var photoOutput: AVCapturePhotoOutput!
    private var customCameraView: CustomCameraView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        customCameraView = CustomCameraView(frame: view.bounds)
        view.addSubview(customCameraView)
        
        customCameraView.captureButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        customCameraView.albumButton.addTarget(self, action: #selector(openAlbum), for: .touchUpInside)
        customCameraView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        customCameraView.tipCloseButton.addTarget(self, action: #selector(backTipButtonTapped), for: .touchUpInside)
    }
    
    private func setupCamera() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("카메라를 사용할 수 없습니다.")
            return }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("비디오 입력 초기화 실패: \(error)")
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            print("비디오 입력을 추가할 수 없습니다.")
            return
        }
        
        photoOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        } else {
            print("사진 출력을 추가할 수 없습니다.")
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    @objc private func openAlbum() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func capturePhoto() {
        
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func backTipButtonTapped() {
        customCameraView.tipView.isHidden = true
    }
}

extension CustomCameraViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("사진 처리 중 오류 발생: \(error.localizedDescription)")
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        let image = UIImage(data: imageData)
        
        /// 이미지 후처리 및 다음 화면으로 이동
        let addReceiptVC = AddReceiptViewController()
        addReceiptVC.image = image
        addReceiptVC.modalPresentationStyle = .fullScreen
        present(addReceiptVC, animated: true, completion: nil)
    }
}

/// UIImagePickerControllerDelegate 및 UINavigationControllerDelegate 채택
extension CustomCameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            
            let addReceiptVC = AddReceiptViewController()
            addReceiptVC.image = image
            
            /// UIImagePickerController가 dismiss된 후에 AddReceiptCompleteViewController를 표시
            picker.dismiss(animated: true) {
                addReceiptVC.modalPresentationStyle = .fullScreen
                self.present(addReceiptVC, animated: true, completion: nil)
            }
            return
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
