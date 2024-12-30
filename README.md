<h1>Slot Machine</h1>


<h2>Description</h2>
This project implements a fully functional slot machine game on an Altera FPGA using SystemVerilog. It leverages key digital design principles such as clock dividers, shift registers, and finite state machines (FSM) to simulate the behavior of a real-world slot machine.
<br />


<h2>Languages and Tools Used</h2>

- <b>SystemVerilog</b>
- <b>Quartus</b> 
- <b>QuestaSim</b>
- <b>FPGA</b>

<h2>Features ✨</h2>
<ul>
    <li><b>Random Number Generation</b>:
        <ul>
            <li>Utilizes clock dividers and shift registers to generate pseudo-random numbers, mimicking the spinning reels of a traditional slot machine.</li>
        </ul>
    </li>
    <li><b>Finite State Machine</b>:
        <ul>
            <li>Tracks four distinct states:</li>
            <li><b>Set</b>: Resets the machine to a default value.</li>
            <li><b>Run</b>: Spins the reels continuously.</li>
            <li><b>Stop</b>: Halts the reels and highlights the stopped number.</li>
            <li><b>Win</b>: Activates a special mode if all numbers match, including fast blinking lights and a buzzer.</li>
        </ul>
    </li>
    <li><b>Interactive Controls</b>:
        <ul>
            <li>A button on the FPGA toggles between states:</li>
            <li>Reset to default.</li>
            <li>Start spinning the reels.</li>
            <li>Stop and hold on a number.</li>
            <li>Trigger a win sequence when conditions are met.</li>
        </ul>
    </li>
    <li><b>Visual and Audio Effects</b>:
        <ul>
            <li>LEDs blink to indicate the stopped number.</li>
            <li>Winning sequences include fast blinking LEDs and a buzzer sound for enhanced feedback.</li>
        </ul>
    </li>
</ul>
