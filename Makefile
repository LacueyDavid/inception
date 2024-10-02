CXX = c++

CXXFLAGS = -Wall -Wextra -Werror -std=c++98 -g

OBJS =											\
												\
							main.o				\
												\

NAME = PmergeMe

all: $(NAME)

$(NAME): $(OBJS)
	$(CXX) -o $(NAME) $^ $(LDFLAGS)

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re
