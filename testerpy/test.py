#coding=utf-8
import os
import random
import string
 
 
def make_txt(name):  # 定义函数名
    # b = os.getcwd() + '\\newdir\\'
    # if not os.path.exists(b):  # 判断当前路径是否存在，没有则创建new文件夹
    #     os.makedirs(b)
    b = os.getcwd()  # 目标文件夹
    b = b + '//'
    filename = 'test' + name + '.txt'  # 在new文件中创建txt
    print(filename)
    file = open(filename, 'w')  # 打开该文件
    for i in range(100):
        file.write(text())  # 写入内容信息
    file.close()
    print('OK')
 
def random_number():
    list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    from random import choice
    return ''.join(str(choice(list)))

def chessname():
    hhh = ['K','Q','N','B','R','P']
    from random import choice
    return ''.join(choice(hhh))

def text():
    setup = 'setup_chess(' + chessname() + ', ' + random_number() + ', '+random_number()+')'
    moveandcap = 'move and capture('+random_number()+', '+random_number()+', '+random_number()+', '+random_number()+')'
    move = 'moves('+random_number()+', '+random_number()+')'


    foo = ['redo','undo',setup, moveandcap, move,'start_game', 'reset game']
    from random import choice
    return ''.join(choice(foo)) + '\n'


 
 
def write_file():
    for i in range(100):
        make_txt(str(i))  # 将生成的字符命名为txt名称，然后将名称*3写入该txt
 
 
write_file()
