def convert_studytime(hours):

    if hours < 2:
        return 1
    elif hours < 4:
        return 2
    elif hours < 6:
        return 3
    else:
        return 4