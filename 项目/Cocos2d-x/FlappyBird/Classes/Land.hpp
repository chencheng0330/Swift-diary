//
//  Land.hpp
//  FlappyBird
//
//  FlappyBird
//
//  Created by 金亮齐 on 2017/7/25.
//
//

#ifndef Land_hpp
#define Land_hpp

#include <stdio.h>
#include "Const.hpp"

class Land:public Layer {
public:
    virtual bool init(bool needPhysics);
    static Land* createLand(bool needPhysics);

private:
    void addFloor(Vec2 position, int zOrder);
};

#endif /* Land_hpp */
