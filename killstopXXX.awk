BEGIN {
    # Define stop words
    split("is the in but can a the is in of to a that it for on with as this was at by an be from or are", stop_words)
    for (i in stop_words) stop[stop_words[i]]
}
{
    line = ""
    for (i = 1; i <= NF; i++) {
        if (!(tolower($i) in stop)) {
            line = line $i " "
        }
    }
    print line
}