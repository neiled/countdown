class CountdownController < UIViewController
  def viewDidLoad
    self.view.backgroundColor = UIColor.whiteColor
    create_labels
    create_buttons
    load_target_date
    update_labels
    
  end

  def create_buttons
    @load_photo_button = UIButton.rounded_rect
    @load_photo_button.setTitle("Pick Photo", forState:UIControlStateNormal)
    @load_photo_button.sizeToFit
    @load_photo_button.frame = CGRect.new([125,500], @load_photo_button.frame.size)
    self.view.addSubview @load_photo_button

    @load_photo_button.addTarget(self, action:'load_photo', forControlEvents: UIControlEventTouchUpInside)
  end

  def load_photo
    picker = UIImagePickerController.alloc.init
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary

    picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceTypePhotoLibrary)

    picker.allowsEditing = false
    picker.delegate = self

    self.presentModalViewController(picker, animated: true)
  end

  def imagePickerController(picker, didFinishPickingMediaWithInfo:info)
    self.dismissViewControllerAnimated(true, completion: nil)
    image = info.objectForKey(UIImagePickerControllerOriginalImage)

    @image_view ||= UIImageView.alloc.initWithFrame([[0,0],[self.view.frame.size.width,self.view.frame.size.height]])
    @image_view.setImage(image)
    self.view.addSubview @image_view
  end

  def viewWillAppear(animated)
    @timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: 'timer_tick', userInfo: nil, repeats: true)
  end

  def create_labels
    @days_label = UILabel.alloc.initWithFrame([[0,50],[self.view.frame.size.width, 50]])
    @days_label.textAlignment = NSTextAlignmentCenter
    self.view.addSubview @days_label

    @hours_label = UILabel.alloc.initWithFrame([[0,100],[self.view.frame.size.width, 50]])
    @hours_label.textAlignment = NSTextAlignmentCenter
    self.view.addSubview @hours_label

    @minutes_label = UILabel.alloc.initWithFrame([[0,150],[self.view.frame.size.width, 50]])
    @minutes_label.textAlignment = NSTextAlignmentCenter
    self.view.addSubview @minutes_label

    @seconds_label = UILabel.alloc.initWithFrame([[0,200],[self.view.frame.size.width, 50]])
    @seconds_label.textAlignment = NSTextAlignmentCenter
    self.view.addSubview @seconds_label



  end

  def load_target_date
    @target_datetime = NSDate.from_components(year: 2015, month: 1, day:1)
  end

  def update_labels
    right_now = NSDate.new

    flags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
    components = NSCalendar.currentCalendar.components(flags, fromDate: right_now, toDate: @target_datetime, options: 0)


    @days_label.text = NSString.stringWithFormat("Days: %@", components.day)
    @hours_label.text = NSString.stringWithFormat("Hours: %@", components.hour)
    @minutes_label.text = NSString.stringWithFormat("Minutes: %@", components.minute)
    @seconds_label.text = NSString.stringWithFormat("Seconds: %@", components.second)
  end

  def timer_tick
    update_labels
  end
end