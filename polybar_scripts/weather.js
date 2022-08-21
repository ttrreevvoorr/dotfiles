#!/usr/bin/node

const OPENWEATHER=""
const CITY=""

const http = require('http');
let type = false

if(process.argv[2]) type = true

const options = {
  host: 'api.openweathermap.org',
  path: `/data/2.5/weather?id=${CITY}&appid=${OPENWEATHER}&units=imperial`
};
//console.log(options.host+options.path)
callback = function(response) {
  let str = '';

  response.on('data', function (chunk) {
    str += chunk;
  });

  //the whole response has been received, so we just print it out here
  response.on('end', function () {
		const data = JSON.parse(str)
		const imperial = data.main.temp
    const main = data.weather[0].main
		const celsius = (imperial-32)/1.8
		let desc = data.weather[0].description

		if(type) {
			return console.log(_toCaps(desc) + " " + _getIcon(desc))
		}
		else {
 		 	return console.log(`${parseInt(imperial)}F°:${parseInt(celsius)}C° ${_getIcon(desc)}`)
		}
	});
}

const _getIcon = (desc) => {
	let icon = ""
	switch(desc){
		case "clear sky":
			let hour = new Date().getHours()
			if(hour < 6 || hour > 18){
					icon = ""
			} 
			else {
					icon = ""
			}
			break;
		case "few clouds":
		case "scattered clouds":
		case "broken clouds":
			icon = ""
			break;
		case "rain":
		case "thunderstorm":
			icon = ""
			break;
		case "snow":
			icon = ""
			break;
		case "fog":
		case "haze":
		case "mist":
			icon = ""
			break;
		default:
			icon =""
			break;
	}
	return icon
}

const _toCaps = (sentence) => {
  const words = sentence.split(" ");

  for (let i = 0; i < words.length; i++) {
    words[i] = words[i][0].toUpperCase() + words[i].substr(1);
  }
	return words.join(" ")
}

http.request(options, callback).end();

