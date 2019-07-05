class CalendarWidget {
  
  selectedDate = moment()
  monthYearElement = $(".month-year")

  constructor(){
    this.monthYearElement.text(this.getDateDisplay())
    this.setDate()
    this.clearDays()
    this.insertDays()
    this.setDateChangeHandler()
  }



  setDate = () => this.monthYearElement.text(this.getDateDisplay())

  getMonth = () => this.selectedDate.format('MMM')

  getYear = ()=> this.selectedDate.format('YYYY')

 

  getDateDisplay =  () => `${this.getMonth()} ${this.getYear()}`
  

  getDate = () => this.selectedDate.toDate()

  setDateChangeHandler = function(){
    let self = this
    $('.arrow-right, .arrow-left').click(function(e){
      if($(e.currentTarget).hasClass('arrow-right')){
        self.selectedDate.add(1, 'months')
        self.clearDays()
        self.insertDays()
      }else{
        self.selectedDate.subtract(1, 'months')
        self.clearDays()
        self.insertDays()
      }
      self.setDate()
    })
  }

  clearDays = function(){
    $(".weeks > div").empty()
    $(".weeks").removeClass('active')
  }

  insertDays = function(){
    
    let dayCounter = moment(this.selectedDate).startOf('month')
    let counter = dayCounter.day()

    for(let i = 1; i <= moment(moment(this.selectedDate).endOf('month').date()); i++, counter++){
        let weekNum = Number.parseInt(counter/7)
        if(!$(`#week-${weekNum}`).hasClass('active')){
          $(`#week-${weekNum}`).addClass('active')
        }
          $(`#week-${weekNum} .day${dayCounter.day()}`).text(dayCounter.date())
        dayCounter.add(1, 'days')
    }
  }

 

  
}