class  Transaction{
  
  constructor(){
    $("#transactions-all-table").DataTable({
      "lengthChange": false,
      "info": false,
      "ordering": false,
      "dom": "tp" 
    })

  }
}