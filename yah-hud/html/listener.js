$(function() {
  function vehicleDisplay(bool) {
    if (bool) {
      $('#car-hud').show();
    } else {
      $('#car-hud').hide();
    }
  }

  vehicleDisplay(false)

  window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === 'carHud') {
      if (item.status == true) {
        vehicleDisplay(true)
      } else {
        vehicleDisplay(false)
      }
    }
  })
})

window.addEventListener('message', (event) => {
	let data = event.data
	if(data.action == 'streetLabel') {
    document.querySelector('#streetName > span').innerText = data.name;
	}

  
  if (data.action == 'hideCarHud') {
    document.getElementById('carhud').hide;
  } 
  else if (data.action == 'showCarHud') {
    document.getElementById('carhud').hide;
  }
})

window.addEventListener('message', (event) => {
	let data = event.data
	if(data.action == 'updateCarHud') {
    document.querySelector('#speed > span').innerText = data.speed;
    document.querySelector('#fuel > span').innerText = data.fuel;
	}

})
