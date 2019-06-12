//
//  ViewController.swift
//  AVSpeechSynthesizerTest
//
//  Created by Peter Jedinger on 23.05.18.
//  Copyright © 2018 Peter Jedinger. All rights reserved.
//

import UIKit
import Speech


class ViewController: UIViewController,  UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    var synthAV: AVSpeechSynthesizer?
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var pitchSlider: UISlider!
    
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    
    @IBOutlet weak var languagePickerView: UIPickerView!
    var pickerData : [String] = []
    var languages:[String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        volumeSliderChanged(self)
        pitchSliderChanged(self)
        rateSliderChanged(self)
        
        
        initLanguages()
        pickerData = Array(languages.keys)
        languagePickerView.delegate = self
        languagePickerView.delegate = self
        languagePickerView.selectRow(0, inComponent: 0, animated: true)
        
        textView.delegate = self;
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAVSpeech(){
        if let text = textView.text{
            let speechUtterance = AVSpeechUtterance(string: text)
            let selectedValue = pickerData[languagePickerView.selectedRow(inComponent: 0)]
            let languageCode = languages.values[languages.index(forKey: selectedValue)!]
            speechUtterance.voice = AVSpeechSynthesisVoice(language: languageCode)
            speechUtterance.rate = rateSlider.value
            //print("language="+selectedValue, "code="+languageCode);
            //            print(AVSpeechUtteranceMinimumSpeechRate)
            //            print(AVSpeechUtteranceDefaultSpeechRate)
            //            print(AVSpeechUtteranceMaximumSpeechRate)
            
            speechUtterance.pitchMultiplier = pitchSlider.value
            speechUtterance.volume = volumeSlider.value
            //speechUtterance.voice = AVSpeechSynthesisVoice(identifier: "")
            
            synthAV = AVSpeechSynthesizer()
            synthAV!.speak(speechUtterance)
        }
    }
    
    @IBAction func stopAVSpeech(){
        if let synth = synthAV{
            synth.stopSpeaking(at: AVSpeechBoundary(rawValue: 0)!)
        }
    }
    
    @IBAction func resetToDefault(){
        volumeSlider.value = 1.0
        rateSlider.value = 0.5
        pitchSlider.value = 1.0
        volumeSliderChanged(self)
        pitchSliderChanged(self)
        rateSliderChanged(self)
    }
    
    @IBAction func volumeSliderChanged(_ sender: Any) {
        let formattedString : NSString = NSString(format: "%.01f", volumeSlider.value)
        volumeLabel.text = formattedString as String
    }
    
    @IBAction func rateSliderChanged(_ sender: Any) {
        let formattedString : NSString = NSString(format: "%.01f", rateSlider.value)
        rateLabel.text = formattedString as String
    }
    
    @IBAction func pitchSliderChanged(_ sender: Any) {
        let formattedString : NSString = NSString(format: "%.01f", pitchSlider.value)
        pitchLabel.text = formattedString as String
    }
    
    func initLanguages(){
        languages = ["German":"de-DE",
                     "English (United States)" : "en-US",
                     "Arabic (Saudi Arabia)" : "ar-SA",
                     "Chinese (China)" : "zh-CN",
                     "Chinese (Hong Kong SAR China)" : "zh-HK",
                     "Chinese (Taiwan)" : "zh-TW",
                     "Czech (Czech Republic)" : "cs-CZ",
                     "Danish (Denmark)" : "da-DK",
                     "Dutch (Belgium)" : "nl-BE",
                     "Dutch (Netherlands)" : "nl-NL",
                     "English (Australia)" : "en-AU",
                     "English (Ireland)" : "en-IE",
                     "English (South Africa)" : "en-ZA",
                     "English (United Kingdom)" : "en-GB",
                     "Finnish (Finland)" : "fi-FI",
                     "French (Canada)" : "fr-CA",
                     "French (France)" : "fr-FR",
                     "Greek (Greece)" : "el-GR",
                     "Hebrew (Israel)" : "he-IL",
                     "Hindi (India)" : "hi-IN",
                     "Hungarian (Hungary)" : "hu-HU",
                     "Indonesian (Indonesia)" : "id-ID",
                     "Italian (Italy)" : "it-IT",
                     "Japanese (Japan)" : "ja-JP",
                     "Korean (South Korea)" : "ko-KR",
                     "Norwegian (Norway)" : "no-NO",
                     "Polish (Poland)" : "pl-PL",
                     "Portuguese (Brazil)" : "pt-BR",
                     "Portuguese (Portugal)" : "pt-PT",
                     "Romanian (Romania)" : "ro-RO",
                     "Russian (Russia)": "ru-RU",
                     "Slovak (Slovakia)" : "sk-SK",
                     "Spanish (Mexico)" : "es-MX",
                     "Spanish (Spain)" : "es-ES",
                     "Swedish (Sweden)" : "sv-SE",
                     "Thai (Thailand)" : "th-TH",
                     "Turkish (Turkey)" : "tr-TR"]
    }
    
}

extension ViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    /* func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
     {
     // use the row to get the selected row from the picker view
     // using the row extract the value from your datasource (array[row])
     selectedLanguage = languages.values[languages.index(forKey: pickerData[row])!]
     }*/
    
    
}

func playTTS(){
    let speechSynthesizer: AVSpeechSynthesizer
    let text = "Hello. This is what iOS Text To Speech sounds like."
    let speechUtterance = AVSpeechUtterance(string: text)
    
    speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    speechUtterance.rate = 0.5
    speechUtterance.pitchMultiplier = 1.0
    speechUtterance.volume = 1.0
    //speechUtterance.voice = AVSpeechSynthesisVoice(identifier: "")
    
    speechSynthesizer = AVSpeechSynthesizer()
    speechSynthesizer.speak(speechUtterance)
}

//    Languages
//    Arabic (Saudi Arabia) - ar-SA
//    Chinese (China) - zh-CN
//    Chinese (Hong Kong SAR China) - zh-HK
//    Chinese (Taiwan) - zh-TW
//    Czech (Czech Republic) - cs-CZ
//    Danish (Denmark) - da-DK
//    Dutch (Belgium) - nl-BE
//    Dutch (Netherlands) - nl-NL
//    English (Australia) - en-AU
//    English (Ireland) - en-IE
//    English (South Africa) - en-ZA
//    English (United Kingdom) - en-GB
//    English (United States) - en-US
//    Finnish (Finland) - fi-FI
//    French (Canada) - fr-CA
//    French (France) - fr-FR
//    German (Germany) - de-DE
//    Greek (Greece) - el-GR
//    Hebrew (Israel) - he-IL
//    Hindi (India) - hi-IN
//    Hungarian (Hungary) - hu-HU
//    Indonesian (Indonesia) - id-ID
//    Italian (Italy) - it-IT
//    Japanese (Japan) - ja-JP
//    Korean (South Korea) - ko-KR
//    Norwegian (Norway) - no-NO
//    Polish (Poland) - pl-PL
//    Portuguese (Brazil) - pt-BR
//    Portuguese (Portugal) - pt-PT
//    Romanian (Romania) - ro-RO
//    Russian (Russia) - ru-RU
//    Slovak (Slovakia) - sk-SK
//    Spanish (Mexico) - es-MX
//    Spanish (Spain) - es-ES
//    Swedish (Sweden) - sv-SE
//    Thai (Thailand) - th-TH
//    Turkish (Turkey) - tr-TR
