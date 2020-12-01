class Output(Exception):
    def __init__(self, output):
        self.output = output
 
class Interrupt(Exception):
    pass
 
class Machine:
    def __init__(self, code):
        self.code = code + [0 for _ in range(100000)]
        self.ip = 0
        self.rb = 0
 
    def run_machine(self, inputs):
        while True:
            opcode = self.code[self.ip] % 100
            if opcode == 99:
                raise Interrupt()
 
            address_mode1 = self.code[self.ip] // 100 % 10
            address_mode2 = self.code[self.ip] // 1000 % 10
            address_mode3 = self.code[self.ip] // 10000 % 10
 
            if address_mode1 == 2:
                value1 = self.rb + self.code[self.ip+1]
            else:
                value1 = self.ip+1 if address_mode1 == 1 else self.code[self.ip+1]
 
            if address_mode2 == 2:
                value2 = self.rb + self.code[self.ip+2]
            else:
                value2 = self.ip+2 if address_mode2 == 1 else self.code[self.ip+2]
 
            if address_mode3 == 2:
                value3 = self.rb + self.code[self.ip+3]
            else:
                value3 = self.ip+3 if address_mode3 == 1 else self.code[self.ip+3]
 
            if opcode == 1:
                self.code[value3] = self.code[value1] + self.code[value2]
                self.ip+=4
            elif opcode == 2:
                self.code[value3] = self.code[value1] * self.code[value2]
                self.ip+=4
            elif opcode == 3:
                self.code[value1] = inputs.pop(0)
                self.ip+=2
            elif opcode == 4:
                output_value = self.code[value1]
                print(self.ip)
                self.ip+=2
                raise Output(output_value)
            elif opcode == 5:
                if self.code[value1] != 0:
                    self.ip = self.code[value2]
                else:
                    self.ip+=3
            elif opcode == 6:
                if self.code[value1] == 0:
                    self.ip = self.code[value2]
                else:
                    self.ip+=3
            elif opcode == 7:
                if self.code[value1] < self.code[value2]:
                    self.code[value3] = 1
                else:
                    self.code[value3] = 0
                self.ip+=4
            elif opcode == 8:
                if self.code[value1] == self.code[value2]:
                    self.code[value3] = 1
                else:
                    self.code[value3] = 0
                self.ip+=4
            elif opcode == 9:
                self.rb += self.code[value1]
                self.ip+=2