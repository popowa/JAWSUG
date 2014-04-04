function getRegions(obj){
    var regions = obj['config']['regions'];
    var regionArray = new Array(regions.length);
    for (var i = 0; i < regions.length; i++) {
      regionArray.push(regions[i]['region']);
    }
    return regionArray;
  }

function drawChart() {
  var data = new google.visualization.DataTable();
  var column = ['price', 'vCPU', 'memoryGiB'];
  data.addColumn('string', 'size');
  for(var i = 0; i < column.length; i++){
    data.addColumn('number', column[i]);
  }
  data.addRows(list);
    var options = {
      colorAxis: {colors: ['yellow', 'red']},
      title: 'AWS Tokyo Region Price Chart Map',
      hAxis: {title: 'Price'},
      vAxis: {title: 'vECU'},
      bubble: {textStyle: {fontSize: 12}}
    };

    var chart = new google.visualization.BubbleChart(document.getElementById('chart_div'));
    chart.draw(data, options);
  }

function xyOptions(){
  selectValues = {"vCPU": "vCPU", "ECU": "ECU","memoryGiB":"memoryGiB","storageGB":"storageGB", "price":"price"  };
  $.each(selectValues, function(key) {   
     $('#xOption').append($('<option>', { value : key }).text(key));
     $('#yOption').append($('<option>', { value : key }).text(key)); 
  });
}


function toOndemandList(obj) {
    var list = [];
    var config = obj['config'];
    var regions = config['regions'];
    //for (var i = 0; i < regions.length; i++) {
        var i = 5;
        var region = regions[i]['region'];
        //var select_region = $('#select_region').val();
        //if(region == select_region) {
            var instypes = regions[i]['instanceTypes'];
            for (var j = 0; j < instypes.length; j++) {
                var sizes = instypes[j]['sizes'];
                for (var k = 0; k < sizes.length; k++) {
                    var size = sizes[k]['size'];
                    var vCPU = sizes[k]['vCPU'];
                    var ECU  = sizes[k]['ECU'];
                    var memoryGiB = sizes[k]['memoryGiB'];
                    var storageGB = sizes[k]['storageGB'];
                    var price     = sizes[k]['valueColumns'][0]['prices']['USD'];
                    list.push([
                        size,
                        {v: parseFloat(price), f: "$" + price},
                        {v: parseInt(vCPU),f: vCPU},
                        {v: parseFloat(memoryGiB), f: memoryGiB}
                    ]);
                }
            }
        //}
    //}
    return list;
}
