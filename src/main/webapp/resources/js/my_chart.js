// const ctx = document.getElementById('myChart').getContext('2d');
// const myChart = new Chart(ctx, {
//     type: 'polarArea',
//     data: {
//         labels: ['Leader', 'Barista', 'Cashier', 'Waiter'],
//         datasets: [
//             {
//                 label: '# of Votes',
//                 data: [3, 2, 1, 5].map((e) => Number.parseInt(e)),
//                 backgroundColor: [
//                     'rgba(255, 99, 132, 1)',
//                     'rgba(54, 162, 235, 1)',
//                     'rgba(255, 206, 86, 1)',
//                     'rgba(230, 206, 86, 1)',
//                 ],
//                 borderColor: [
//                     'rgba(255, 99, 132, 1)',
//                     'rgba(54, 162, 235, 1)',
//                     'rgba(255, 206, 86, 1)',
//                     'rgba(230, 206, 86, 1)',
//                 ],
//                 borderWidth: 1,
//             },
//         ],
//     },
// });
/*{
	   labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
	   datasets: [
		   {
			   label: '# of Votes',
			   data: [12, 19, 3, 5, 2, 3],
			   backgroundColor: [
				   'rgba(255, 99, 132, 1)',
				   'rgba(54, 162, 235, 1)',
				   'rgba(255, 206, 86, 1)',
				   'rgba(75, 192, 192, 1)',
				   'rgba(153, 102, 255, 1)',
				   'rgba(255, 159, 64, 1)',
			   ],
			   borderColor: [
				   'rgba(255, 99, 132, 1)',
				   'rgba(54, 162, 235, 1)',
				   'rgba(255, 206, 86, 1)',
				   'rgba(75, 192, 192, 1)',
				   'rgba(153, 102, 255, 1)',
				   'rgba(255, 159, 64, 1)',
			   ],
			   borderWidth: 1,
		   },
	   ],
   },*/
$.ajax({
	type: 'GET',
	url: `http://localhost:8080/QLNV_QTS/manager/num-of-shift-of-pt-emp.htm`,
	headers: {
		Accept: 'application/json',
		'Content-Type': 'application/json;charset=utf-8'
	}
})
	.done(function(res) {
		$('#loader').remove();
		$('.card.chart').append('<canvas id="my-chart" style="max-height: 80vh; width: 100%"></canvas>')
		res = JSON.parse(res);
		const labels = res.map(item => item.firstName + ' ' + item.lastName);
		const dataEmp = res.map(item => item.numOfShift)
		const bgColor = [
			'rgba(255, 99, 132, 0.2)',
			'rgba(255, 159, 64, 0.2)',
			'rgba(255, 205, 86, 0.2)',
			'rgba(75, 192, 192, 0.2)',
			'rgba(54, 162, 235, 0.2)',
			'rgba(153, 102, 255, 0.2)',
			'rgba(201, 203, 207, 0.2)'
		]
		const borderColor = [
			'rgb(255, 99, 132)',
			'rgb(255, 159, 64)',
			'rgb(255, 205, 86)',
			'rgb(75, 192, 192)',
			'rgb(54, 162, 235)',
			'rgb(153, 102, 255)',
			'rgb(201, 203, 207)'
		]
		let lenOfColorArr = borderColor.length;
		const numOfColor = lenOfColorArr - 1;
		while (lenOfColorArr < dataEmp.length) {
			borderColor.push(borderColor[lenOfColorArr % numOfColor])
			bgColor.push(bgColor[lenOfColorArr % numOfColor])
			lenOfColorArr++;
		}
		const ctxBar = document.getElementById('my-chart').getContext('2d');
		const data = {
			labels: labels,
			datasets: [{
				axis: 'y',
				label: 'Number of shift of employee',
				data: dataEmp,
				fill: false,
				backgroundColor: bgColor,
				borderColor: borderColor,
				borderWidth: 1
			}]
		};
		const myChartBar = new Chart(ctxBar, {
			type: 'bar',
			data: data,
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					title: {
						display: true,
						text: 'The number of shifts of part-time employees in the month',
						font: {
							size: 20,
							weight: 'bold',
							lineHeight: 1.2,
						},
					},
					legend: {
						display: false
					}
				}
			},
		});

	})
	.fail(function(err) {
		console.log(err)
	})/*
   fetch(
		 `http://localhost:8080/QLNV_QTS/manager/num-of-shift-of-pt-emp.htm`, {
			method: 'GET',
			mode: 'no-cors',
			'Content-Type': 'application/json',
			Accept: 'application/json'
		}
	)
	.then(response => {
		console.log(response.status);
		return response.json();
	})
	.then(function(res) {
		console.log(res)
	})
	.catch(console.log)
*/