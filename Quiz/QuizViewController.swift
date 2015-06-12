//
//  QuizViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    //出題数
    var questionNumber:Int = 5
    
    //現在の問題数
    var sum:Int = 0
    
    //正解数
    var correctAnswer:Int = 0
    
    //乱数
    var random:Int = 0
    
    //クイズを格納する配列
    var quizArray = [NSMutableArray]()
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons: Array<UIButton>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //------------------------ここから下にクイズを書く------------------------//
        quizArray.append(["お味噌汁の位置は？","中央","左","右",3])
        quizArray.append(["写真を撮る時は？","適当に","被写体です！","メインを決めます",3])
        quizArray.append(["ニコニコマークを書く時に最も気をつけることは？","目","口","顔の輪郭",3])
        quizArray.append(["書き初めで心がけることは？","早く終われ〜","筆使い","バランス",3])
        quizArray.append(["音楽を聴くなら？","定番曲","音楽は嫌いです。","なんでも聴く",3])
        quizArray.append(["茶道でお手前をうけたら？","すぐ飲む。","お手前？","回してみるか！",3])

        //------------------------ここから下にクイズを書く------------------------//
        choiceQuiz()
    }
    
    func choiceQuiz() {
        println(quizArray.count)
        //クイズの問題文をシャッフルしてTextViewにセット
        random = Int(arc4random_uniform(UInt32(quizArray.count)))
        quizTextView.text = quizArray[random][0] as! NSString as String!
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        for var i = 0; i < choiceButtons.count; i++ {
            choiceButtons[i].setTitle(quizArray[random][i+1] as! NSString as String,forState: .Normal)
            
            //どのボタンが押されたか判別するためのtagをセット
            choiceButtons[i].tag = i + 1;
        }
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        sum++
        println("random \(random)")
        if quizArray[random][4] as! Int == sender.tag {
            //正解数を増やす
            correctAnswer++
        }
        //if (quizArray[random][4]){
            
        
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if sum == questionNumber {
            performSegueToResult() //結果画面へ
        }
        quizArray.removeAtIndex(random)
        choiceQuiz()
    }
  /*  if(correctAnswer > 4)
    System.out.println("あなたはセンスがあります")
    }
    if (correctAnswer >= 2 && 4 > correctAnswer ){
    System.out.println("普通です。")
    }
    if ( correctAnswer >=0 && 2 > correctAnswer){
    System.out.println("頑張りましょう!")
    }*/
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultView") {
            
            var ResultView : ResultViewController = segue.destinationViewController as! ResultViewController

            ResultView.correctAnswer = self.correctAnswer
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


