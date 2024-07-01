//
//  IntroVC.swift
//  StarSEexam
//
//  Created by Toe Wai Aung on 01/07/2024.
//

import UIKit

class IntroVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var slides:[Slide] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "ic_hired1")
        slide1.labelTitle.text = "STAR SEからよこそ!"
        slide1.labelDesc.text = "STAR SEの社員、応募者向けの試験受けるアプリです"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "ic_hired2")
        slide2.labelTitle.text = "どう使いますか?"
        slide2.labelDesc.text = "ご利用希望の方は STAR SE をお問合せくさい"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "ic_hired3")
        slide3.labelTitle.text = "次はログイン..."
        slide3.labelDesc.text = "IDとパスワードでログインしてください"
        
        return [slide1, slide2, slide3]
    }
    
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     *
     */
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
         pageControl.currentPage = Int(pageIndex)
         
         let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
         let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
         
         // vertical
         let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
         let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
         
         let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
         let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
         
         
         /*
          * below code changes the background color of view on paging the scrollview
          */
 //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
         
     
         /*
          * below code scales the imageview on paging the scrollview
          */
         let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
         
         if(percentOffset.x > 0 && percentOffset.x <= 0.5) {
             slides[0].imageView.transform = CGAffineTransform(scaleX: (0.5-percentOffset.x)/0.5, y: (0.5-percentOffset.x)/0.5)
             slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.5, y: percentOffset.x/0.5)
             
         } else if(percentOffset.x > 0.5 && percentOffset.x <= 1) {
             slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.5, y: (0.50-percentOffset.x)/0.5)
             slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
         }
     }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
            pageControl.pageIndicatorTintColor = StarSEColor.tutorialGray.instance(0.5)
            slides[pageControl.currentPage].backgroundColor = StarSEColor.disableColor.instance(0.5)
            
            pageControl.currentPageIndicatorTintColor = StarSEColor.tutorialBlue.instance(0.5)
        }
    }
    
}
