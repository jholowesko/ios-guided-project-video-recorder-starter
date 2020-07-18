import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    // MARK: - Properties
    
    lazy private var captureSession = AVCaptureSession()
    
    // MARK: - IBOutlets
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var cameraView: CameraPreviewView!

    // MARK: - View Lifecycle
    
	override func viewDidLoad() {
		super.viewDidLoad()

		// Resize camera preview to fill the entire screen
		cameraView.videoPlayerView.videoGravity = .resizeAspectFill
        
        setUpCaptureSession()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        captureSession.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        captureSession.stopRunning()
    }

    // MARK: - IBActions
    
    @IBAction func recordButtonPressed(_ sender: Any) {

	}
	
    // MARK: - Methods
    
    private func setUpCaptureSession() {
        
        captureSession.beginConfiguration()
        
        // Add inputs
        let camera = bestCamera()
        
        // video
        guard let captureInput = try? AVCaptureDeviceInput(device: camera),
            captureSession.canAddInput(captureInput) else {
                fatalError("Can't create the input from the camera")
        }
        captureSession.addInput(captureInput)
        
        if captureSession.canSetSessionPreset(.hd1920x1080) {
            captureSession.sessionPreset = .hd1920x1080
        }
        
        // audio
        
        
        // Add outputs
        
        // Recording to disk
        
        captureSession.commitConfiguration()
        
        // Live Preview
        cameraView.session = captureSession
    }
    
    private func bestCamera() -> AVCaptureDevice {
        // All iPhones have a wide angle camera (front & back)
        if let ultraWideCamera = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .back) {
            return ultraWideCamera
        }
        
        if let wideCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            return wideCamera
        }
        
        fatalError("No camera on the device (or you're running this on a Simulator - which isn't supported)")
    }
    
	/// Creates a new file URL in the documents directory
	private func newRecordingURL() -> URL {
		let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

		let formatter = ISO8601DateFormatter()
		formatter.formatOptions = [.withInternetDateTime]

		let name = formatter.string(from: Date())
		let fileURL = documentsDirectory.appendingPathComponent(name).appendingPathExtension("mov")
		return fileURL
	}
}

