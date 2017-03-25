
import rocket
from rocket import aux
import numpy as np
from scipy.misc import imread
from math import pi, sqrt
from vispy.gloo import IndexBuffer, Texture2D

SIZE = 600
BACK = (0, 0, 0)


def uvsphere(radius, h, v):
    size = h*v
    index_count = size*2 - h*2  # hard to explain
    # What is rad for?
    rad = np.full(size, radius, dtype=np.float32)
    azi = np.zeros(size, dtype=np.float32)
    inc = np.zeros(size, dtype=np.float32)
    tex = np.zeros((size, 2), dtype=np.float32)
    ind = np.zeros(index_count, dtype=np.uint32)
    # TODO: Explain this boggy mess.
    for row in range(h):
        lat = pi * row / (h-1)
        t_y = row / (h-1)
        for col in range(v):
            i   = row*h + col
            lon = pi * 2 * col / (v-1)
            t_x = col / (v-1)
            inc[i] = lat
            azi[i] = lon
            tex[i, :] = (t_x, t_y)
    # Generate indices for triangle_strip in another step.
    n1, n2 = 0, h
    for i in range(index_count):
        if i%2 == 0:
            ind[i] = n1
            n1 += 1
        else:
            ind[i] = n2
            n2 += 1
    return rad, azi, inc, tex, IndexBuffer(ind)


@rocket.attach
def draw():
    program['rad'] = rad
    program['azi'] = azi
    program['inc'] = inc
    program['tex'] = tex
    program['modl'] = sphere.transform
    program['view'] = camera.transform
    program['proj'] = camera.proj
    program['slate'] = slate
    program['color'] = (0.0, 0.0, 0.0, 1.0)
    program.draw('triangle_strip', ind)
    #program['color'] = (0.2, 0.3, 0.4, 1.0)
    #program.draw('points')


@rocket.attach
def key_press(key):
    if key == "R":
        load_texture()


@rocket.attach
def left_drag(start, end, delta):
    sphere.rotate(x=delta[0], y=delta[1])


@rocket.attach
def scroll(point, direction):
    camera.move(0, 0, direction/10)


def main():
    global rad, azi, inc, tex, ind
    init()
    load_texture()
    rad, azi, inc, tex, ind = uvsphere(1, 32, 32)
    rocket.prep(size=(SIZE, SIZE), clear_color=BACK)
    rocket.launch()


def init():
    global program, camera, sphere
    program = rocket.program("v.glsl", "f.glsl")
    camera = aux.View(fov=45)
    sphere = aux.Mover()
    camera.move(z=-4)


def load_texture():
    global slate
    # This is the texture.
    #slate = np.full((500, 500, 3), 128, dtype=np.uint8)
    slate = Texture2D(imread("planet.png"), wrapping='repeat')


if __name__ == '__main__':
    main()
