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

    // MARK: - IBActions
    
    @IBAction func recordButtonPressed(_ sender: Any) {

	}
	
    // MARK: - Methods
    
    private func setUpCaptureSession() {
        
        captureSession.beginConfiguration()
        
        // Add inputs
        
        // video
        
        // audio
        
        // Add outputs
        
        // Live preview
        
        // Recording to disk
        
        captureSession.commitConfiguration()
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

