class CountdownController < UIViewController
  def viewDidLoad
    self.view.backgroundColor = UIColor.whiteColor
    create_labels
    load_target_date
    update_labels
    
  end
  
  def viewWillAppear(animated)
    @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: 'timer_tick', userInfo: nil, repeats: true)
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
    days_total = (@target_datetime.timeIntervalSinceDate(right_now)/(60*60*24))
    days = days_total.to_i
    hours_total = (days_total - days) * 24
    hours = hours_total.to_i
    minutes_total = (hours_total - hours) * 60
    minutes = minutes_total.to_i
    seconds_total = (minutes_total - minutes) * 60
    seconds = seconds_total.to_i
    @days_label.text = NSString.stringWithFormat("%@", days)
    @hours_label.text = NSString.stringWithFormat("%@", hours)
    @minutes_label.text = NSString.stringWithFormat("%@", minutes)
    @seconds_label.text = NSString.stringWithFormat("%@", seconds)


  end

  def timer_tick
    update_labels
  end
end