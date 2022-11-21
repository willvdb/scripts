const csv = require('csvtojson')
const writeCsv = require('csvwriter')
const fs = require('fs');
const headers = [
	'Last Name',
	'First Name',
	'Address',
	'City',
	'State',
	'Zip',
	'Country',
	'How many per invite',
	'Not Coming',
	'Coming',
	'Shower Gift Received',
	'Thank you Ssent',
	'Wedding Gift Received',
	'Thank you Sent'
]
const headersObj = {
	'Last Name': '',
	'First Name': '',
	'Address': '',
	'City': '',
	'State': '',
	'Zip': '',
	'Country': '',
	'How many per invite': '',
	'Not Coming': '',
	'Coming': '',
	'Shower Gift Received': '',
	'Thank you Ssent': '',
	'Wedding Gift Received': '',
	'Thank you Sent': ''
}

async function parse() {
	csv().fromFile('/home/will/code/scripts/test.csv').then(elsas => {
		csv().fromFile('/home/will/code/scripts/elsa_mom_list.csv').then(moms => {
			elsas.forEach((line) => {
				moms.push({
					...headersObj,
					'Last Name': line.last_name,
					'First Name': line.first_name,
					'Address': line.address_line_1 + ' ' + line.address_line_2,
					'City': line.city,
					'State': line.state,
					'Zip': line.postal_code,
					'Country': line.country
				})
			})
			console.log(moms);
			writeCsv(moms, {delimiter: ','}, (err, csv) => {
				fs.writeFile('./wedding_list.csv', csv, 'utf8', (err) => {
			      if (err) console.log(err)
			      else console.log('success!')
			    })
			})
		})
	})
}




parse()
