users = @User.create([{ first_name: 'Anthony', last_name: 'Dao', uin: "828006672", email: "anvdao@gmail.com", phone_number: '7132547212', dob: '2001-07-24', points: '3', role: '3'},
    { first_name: 'Peter', last_name: 'Griffin', uin: "828006673", email: "peterg@gmail.com", phone_number: '321312345', dob: '2001-07-25', points: '3', role: '2'}
    { first_name: 'Tracy', last_name: 'Nguyen', uin: "828006674", email: "trang@gmail.com", phone_number: '1234563213', dob: '2001-07-26', points: '3', role: '3'}
    { first_name: 'Testo', last_name: 'Tiesto', uin: "828006676", email: "test@gmail.com", phone_number: '7312321314', dob: '2001-07-27', points: '3', role: '4'}
    { first_name: 'Master', last_name: 'Oogway', uin: "828006679", email: "oogway@gmail.com", phone_number: '898929320', dob: '2001-07-28', points: '3', role: '1'}])

User.create(user: users.first)
