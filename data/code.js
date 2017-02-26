var plotvalg = {series: 
						{marker: 
							{enabled: true, radius: 3
							}
						}
				};
var legende = {align: 'center',
				x: 0,
				y: 0,
				floating: true,
				borderWidth: 1,
				backgroundColor: '#FFFFFF',
				shadow: true
					};
var number = {formatter: function() {return '' + this.series.name +'<br>Uke ' + this.x + ': ' + this.y + ' ';}
					};
var percent = {formatter: function() 
               {return ''+this.series.name +'<br>Uke '+ this.x +': '+ this.y +'%';}
              }	;
var notitle = {text: null};
var xaxisstandard = {style: {
                        color: 'black'},
				        align: 'center', x: 0, y: 10
				        };
var noscroll = {enabled: false};

var yakse = { 
						min: 10000,
						startOnTick: false,
						minPadding: 0,
						gridLineWidth: 1,
						<!-- lineWidth: 0, -->
						title: {
							text: 'Daglige brukere, ukesnitt',
							align: 'high'
						}};
                            
var xakse = {
				        lineWidth: 0, 
                        labels: xaxisstandard,
						tickInterval: 5,
						categories: uker
					}