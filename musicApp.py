import pymysql;


def main_menu():
    print('***Please select from the following menu options***')
    print('1 - change password ')  # yes
    print('2 - view recommended list of songs ')  # yes
    print('3 - check the playlists you owned ')  # yes
    print('4 - Search a song by its name ')  # yes
    print('5 - Search songs by artists name ')  # yes
    print('6 - Search songs by record label ')  # yes
    print('7 - Create a new playlist ')  # yes
    print('8 - Edit playlist ')  # yes
    print('q - quit the program ')
    print(' ')


def login(connection):
    username = str(input('Enter your username: '))
    password = str(input('Enter your password: '))
    c1 = connection.cursor()
    c1.callproc('login', (username, password))
    data = c1.fetchall()
    for ele in data[0]:
        print(ele)
        if ele == 'Incorrect login information, please try again or restart the App to get a new account':
            return ele

    return username


def register(connection):
    print('Welcome to registration!')
    username = str(input('Enter the username wanted: '))
    password = str(input('Enter the password wanted: '))
    password_validate = str(input('Enter the password again: '))
    age = int(input('Enter your age: '))
    while password != password_validate:
        print('Please make sure both passwords match!')
        password = str(input('Enter the password wanted: '))
        password_validate = str(input('Enter the password again: '))
    c2 = connection.cursor()
    c2.callproc('userRegister', (username, age, password))
    data = c2.fetchall()
    for ele in data:
        print(ele['s'])
        if ele['s'] == 'User already exists':
            print('oh no please register with other username')
        else:
            print('Welcome ' + username + '!')

    return username

def change_password(connection, username):
    # changePassword (IN usernameIN VARCHAR(256), IN passwordWanted VARCHAR(256))
    new_password = str(input('Enter the new password: '))
    new_password_validate = str(input('Enter the new password again: '))
    while new_password != new_password_validate:
        print('Please make sure both passwords match!')
        new_password = str(input('Enter the new password: '))
        new_password_validate = str(input('Enter the new password again: '))
    c1 = connection.cursor()
    c1.callproc('changePassword', (username, new_password))
    data = c1.fetchall()
    for ele in data[0]:
        print(ele)


def show_recommended_list(connection):
    print('***Here is the list of songs we recommend***')
    c1 = connection.cursor()
    c1.callproc('displayRecommendedList')
    data = c1.fetchall()
    for ele in data:
        print(ele)
    # have a option to add song, or go back to main menu


def get_user_id(connection, username):
    # userInfo(IN usernameIN VARCHAR(256))
    user_id = None
    c1 = connection.cursor()
    query1 = 'SELECT userID from users WHERE username = %s'
    c1.execute(query1, username)
    data = c1.fetchall()
    for ele in data:
        user_id = ele['userID']
    return user_id


def display_song_in_list(connection, list_num):
    c1 = connection.cursor()
    c1.callproc('displaySongInUserlist', (str(list_num), 1))
    data = c1.fetchall()
    for ele in data:
        print(ele)


def edit_user_playlist(connection, list_to_edit, user_id):
    display_song_in_list(connection, list_to_edit)
    song_id_delete = input('Which song you want to remove from this list(provide the songID): ')
    c2 = connection.cursor()
    c2.callproc('deleteSongFromUserlist', (user_id, song_id_delete, list_to_edit))
    data2 = c2.fetchall()
    for ele in data2[0]:
        print(ele)


def display_current_list_own(connection, user_id):
    c1 = connection.cursor()
    c1.callproc('displayCurrentlistOwn', str(user_id))
    data = c1.fetchall()
    print('***Here is your playlist***')
    for ele in data:
        print(ele)


def show_users_playlist(connection, user_id):
    display_current_list_own(connection, user_id)
    # within this option you can select to display songs in a list wanted - after its done go back to main,
    # edit playlist, and pick the playlist you wanted to edit
    print('***These are the operations you can perform with your list***')
    print('1 - Display the songs within the playlist')
    print('2 - Edit playlist')
    print('3 - Back to main menu')
    decision = input('Enter the operations you desired:  ')
    if decision == '1':
        list_wanted = input('Which list you want: ')
        display_song_in_list(connection, list_wanted)

    elif decision == '2':
        list_to_edit = input('Which list you want to edit(use the playlistID): ')
        edit_user_playlist(connection, list_to_edit, user_id)

    else:
        return


def create_new_playlist(connection, user_id):
    name_of_list = input('What do you want to name this new playlist? : ')
    c1 = connection.cursor()
    c1.callproc('createPlaylist', (name_of_list, user_id))
    data = c1.fetchall()
    for ele in data[0]:
        print(ele)


def search_by_song_name(connection, user_id):
    song_name = str(input('What is name of the song? : '))
    c1 = connection.cursor()
    c1.callproc('searchSongByName', (song_name, user_id))
    data = c1.fetchall()
    for ele in data:
        print(ele)
    print('Here are the operations you can do: ')
    print('1 - Add song to your playlist')
    print('2 - Create a new playlist and add song to your playlist')
    print('3 - Return to main menu')
    decision = input('Enter your decision: ')
    if decision == '1':
        add_song_to_playlist(connection, user_id)

    elif decision == '2':
        create_new_playlist(connection, user_id)
        add_song_to_playlist(connection, user_id)

    else:
        return


def display_all_artist(connection):
    c1 = connection.cursor()
    c1.callproc('displayArist')
    data = c1.fetchall()
    for ele in data:
        print(ele)


def add_song_to_playlist(connection, user_id):
    display_current_list_own(connection, user_id)
    list_wanted = input('Enter the list you want the song be added to: ')
    song_id = input('Enter songID of the song: ')
    # addSongToPlaylist(IN idOfOwner INT,IN idOfPlaylist INT,IN idOfSong INT)
    c2 = connection.cursor()
    c2.callproc('addSongToPlaylist', (user_id, list_wanted, song_id))
    data2 = c2.fetchall()
    for ele in data2[0]:
        print(ele)


def search_by_artist_name(connection, user_id):
    display_all_artist(connection)
    artist_wanted = str(input('Enter the name of the Artist you want to look up: '))
    c1 = connection.cursor()
    c1.callproc('searchSongByArtist', (artist_wanted, user_id))
    data = c1.fetchall()
    for ele in data:
        print(ele)
    print('Here are the operations you can do: ')
    print('1 - Add song to your playlist')
    print('2 - Create a new playlist and add song to your playlist')
    print('3 - Return to main menu')
    decision = input('Enter your decision: ')
    if decision == '1':
        add_song_to_playlist(connection, user_id)

    elif decision == '2':
        create_new_playlist(connection, user_id)
        add_song_to_playlist(connection, user_id)

    else:
        return


def search_by_record_label(connection, user_id):
    # displayRecordLabel ()
    c1 = connection.cursor()
    c1.callproc('displayRecordLabel')
    data = c1.fetchall()
    for ele in data:
        print(ele)
    label_id = input('Enter the labelID you want to look at: ')
    # searchSongByRecord (IN recordName VARCHAR(256), IN userID INT)
    c2 = connection.cursor()
    c2.callproc('searchSongByRecord', (label_id, 1))
    data2 = c2.fetchall()
    for ele in data2:
        print(ele)
    print('Here are the operations you can do: ')
    print('1 - Add song to your playlist')
    print('2 - Create a new playlist and add song to your playlist')
    print('3 - Return to main menu')
    decision = input('Enter your decision: ')
    if decision == '1':
        add_song_to_playlist(connection, user_id)

    elif decision == '2':
        create_new_playlist(connection, user_id)
        add_song_to_playlist(connection, user_id)

    else:
        return


def main_operations(connection, username, user_id):
    userchoice = str(input('Enter the operations you desired: '))
    while userchoice != 'q':
        if userchoice == '1':
            change_password(connection, username)

        elif userchoice == '2':
            show_recommended_list(connection)

        elif userchoice == '3':
            show_users_playlist(connection, user_id)

        elif userchoice == '4':
            search_by_song_name(connection, user_id)

        elif userchoice == '5':
            search_by_artist_name(connection, user_id)

        elif userchoice == '6':
            search_by_record_label(connection, user_id)

        elif userchoice == '7':
            create_new_playlist(connection, user_id)

        elif userchoice == '8':
            display_current_list_own(connection, user_id)
            list_to_edit = input('Which list you want to edit(use the playlistID): ')
            edit_user_playlist(connection, list_to_edit, user_id)

        main_menu()
        userchoice = str(input('Enter the operations you desired: '))


def main():
    try:
        databaseUsername = input ('Please enter your local database username: ')
        databasePassword = input('Please enter your local database password: ')
        connection = pymysql.Connection(host='localhost',
                                        user=databaseUsername,
                                        password=databasePassword,
                                        database='musicApp',
                                        cursorclass=pymysql.cursors.DictCursor,
                                        autocommit=True)
        print(' ')
        print('Welcome to the best Music App you will ever experience!!!')
        print("Please select from the following options: " + '\n'
                                                             "1 - Login " + '\n'
                                                                            "2 - Register for a new account ")
        decision = input('Make your decision: ')
        username = ''
        user_id = None

        if decision == '1':
            print('***Please enter your credentials below***')
            username = login(connection)
            while username == 'Incorrect login information, please try again or restart the App to get a new account':
                username = login(connection)
            print("Welcome " + username + '!')
            user_id = get_user_id(connection, username)
            main_menu()
            main_operations(connection, username, user_id)

        elif decision == '2':
            username = register(connection)
            user_id = get_user_id(connection, username)
            main_menu()
            main_operations(connection, username, user_id)

        connection.close()
        print('Bye Now! Hope to see you again soon!')

    except:
        print('Opps, some error has occurred please try to restart the app! Make sure all the credentials are correct.')

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    main()
