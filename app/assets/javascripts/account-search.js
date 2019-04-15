class  AccountSearch{
  
  constructor(){

    $.validator.addMethod('datesRange', function(val, ele, param){
      if($('#transaction_start_date').val().length && $('#transaction_end_date').val().length){
        return Date.parse($('#transaction_start_date').val()) <  Date.parse($('#transaction_end_date').val())
      } else{
        return true
      }
    }, "start date must occur before end date")

    let $form = $("#search-transaction-modal form").validate({
      errorPlacement: function(error, element) {
        error.appendTo( $(element).closest(".form-group"));
      },
      highlight: function(element, errorClass, validClass) {
        $(element).addClass(errorClass).removeClass(validClass);
        $(element).closest('.input-group').addClass(errorClass).removeClass(validClass);
        $(element.form).closest("label[for=" + element.id + "]")
          .addClass(errorClass);
      },
      unhighlight: function(element, errorClass, validClass){
        $(element).addClass(validClass).removeClass(errorClass);
        $(element).closest('.input-group').addClass(validClass).removeClass(errorClass);
        $(element.form).closest("label[for=" + element.id + "]")
          .remove()
        $(element).closest(".form-group").removeClass(errorClass)
      },
      rules: {
        'transaction[start_date]':{
          required: function(){
            return $("#transaction_end_date").val().length > 0
          },
          'datesRange' : true
        },
        'transaction[end_date]':{
          required: function(){
            return $("#transaction_start_date").val().length > 0
          },
          'datesRange' : true
        },
        'transaction[description]':  {
        }
      },

      submitHandler: function(form){
        $(form).submit()
      }
    })
    


    let $modal = $("#search-transaction-modal").modal({
      show: false
    })

    $modal.on('hidden.bs.modal', function(){
      $("#search-transaction-modal form :input").val('')
    })

    $modal.on('shown.bs.modal', function(e){
      $("#transaction_end_date, #transaction_start_date").datepicker({
        clearBtn: true,
        autoclose: true,
        container: '#search-transaction-modal .modal-body #date-picker-container'
      });
      $("#transaction_end_date, #transaction_start_date").datepicker().on('show', function(e){
        $(".datepicker.datepicker-dropdown").css({"top": "0", "left": "0", 'z-index': '10001'})
        $("#search-transaction-modal-bttn, #search-transaction-modal button.close").css({'pointer-events': 'none'})
        $("#search-transaction-modal #new_transaction").hide()
        $("#date-picker-container").css( "display", "flex" )
        e.preventDefault()
      })

      $("#transaction_end_date, #transaction_start_date").datepicker().on('hide', function(e){
        $(".datepicker.datepicker-dropdown").css({"top": "", "left": "", 'z-index': ''})
        $("#search-transaction-modal-bttn, #search-transaction-modal button.close").css({'pointer-events': 'auto'})
        $("#search-transaction-modal #new_transaction").show()
        $("#date-picker-container").hide()
        e.preventDefault()
      })

    })

    $("#search-transaction-bttn").click(function(e){
      $modal.modal('show')
      $form.resetForm() 
      $("#search-transaction-modal form .error").removeClass('error')
      e.preventDefault()
    })

    $("#cancel-datepicker-link").click(function(){
      $("#transaction_end_date, #transaction_start_date").datepicker('hide')
    })

    $("#search-transaction-modal-bttn").click(function(){
      $("#search-transaction-modal form")[0].submit()
    })


  }
}