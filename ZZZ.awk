# Print top words from the TOP_WORDS file
PASS == 1 {
    top_words[$1] = 1 # Maintains the list for easy access later
    top_word_list[++num_words] = $1 # Lets us iterate over it properly
    printf $1 ","
    next
}


# Actually process the frequencies
function count_words() {
    # Initialize counts to 0 for those that wouldn't be incremented
    for (i = 1; i <= num_words; i++) {
        word_counts[top_word_list[i]] = 0 #Lets us iterate in order -  without it, it'd be sorted differently from header
    }

    # Count word occurrences
    split(paragraph, words, " ")
    for (i = 1; i <= length(words); i++) {
        word = words[i]
        if (word in top_words) {
            word_counts[word]++
        }
    }

    # Output the counts of each num word
    output = ""
    for (i = 1; i <= num_words; i++) {
        output = output word_counts[top_word_list[i]] "," # Appends onto existing output
    }
    print output
}

# Count word frequencies per paragraph
PASS == 2 {
    # For the line break so we don't need to make an additional block just for that.
    if (line_break == 0) { 
        print ""
        line_break = 1
    }
    # Starts a fresh paragraph
    if ($0 == "") {
        count_words()
        paragraph = "" 
    } else {
        paragraph = paragraph $0 " " # Continues an existing paragraph
    }
}
