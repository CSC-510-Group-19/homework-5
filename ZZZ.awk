# Initialize top_words array
BEGIN {
    split($(TOP_WORDS), top_words)
}

# Step 5: Generate table of word frequencies per paragraph
PASS==1 {
    output = ""
    for(i in top_words) output = output top_words[i] ", "
    print output
    output = ""
}

# Define a function to count words
function count_words(words, num_words,   top_words,word,word_counts) {
    # Initialize word_counts array
    word_counts[0] = 0
    
    # Count the occurrences of each word
    for(word in words){
        if(word in top_words){
            j = 1
            while(j <= num_words && word_counts[j]) {
                j++
            }
            if (j <= num_words) {
                word_counts[j]++
            }
        }
    }
    
    # Print the counts
    for(i=1; i<=num_words; i++) {
        print word_counts[i]
    }
}

PASS==2 {
    # Count words for each paragraph
    split(paragraph, words)
    count_words(words, length(words))
}