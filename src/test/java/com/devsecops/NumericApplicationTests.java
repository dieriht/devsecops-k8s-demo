package com.devsecops;


import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;


import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
//import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;

import org.junit.jupiter.api.Test;
@SpringBootTest
@AutoConfigureMockMvc
@Autowired

class NumericApplicationTests {

    private Object mockMvc;

    @Test
    void smallerThanOrEqualToFiftyMessage() throws Exception {
        ((MockMvc) this.mockMvc).perform(get("/compare/50")).andDo(print()).andExpect(status().isOk())
                .andExpect(content().string("Smaller than or equal to 50"));
    }

    @Test
    void greaterThanFiftyMessage() throws Exception {
        ((MockMvc) this.mockMvc).perform(get("/compare/51")).andDo(print()).andExpect(status().isOk())
                .andExpect(content().string("Greater than 50"));


    }

}