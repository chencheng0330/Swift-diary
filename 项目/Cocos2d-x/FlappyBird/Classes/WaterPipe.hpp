//
//  WaterPipe.hpp
//  FlappyBird
//
//  FlappyBird
//
//  Created by 金亮齐 on 2017/7/25.
//
//

#ifndef WaterPipe_hpp
#define WaterPipe_hpp

#include "Const.hpp"

enum WaterPipeType {
    Normal = 0, // 正常样式 %80
    Move,       // 上下移动 % 10
    Plant,      // 有植物的水管 %10
};

enum WaterPipeColorType {
    GreenColor = 0,
    RedColor,
    BlueColor
};


class WaterPipe:public Layer {
    
public:
    virtual bool init(WaterPipeColorType color, float height, bool showCoin);
    static WaterPipe* createWaterPipe(WaterPipeColorType color, float height, bool showCoin);
    Sprite *_coin;
    void setChildPhysicsBodyEnabled(bool enabled);
    
    void pause();
    void resume();
    void stopGame();
    WaterPipeType type;
private:
    Sprite *_topPipe;
    Sprite *_bottomPipe;
    Sprite *_plant;
    Vector<Node *> _phyBodys;
    
    char fileName[30];
    
    bool _showCoin;
    float _topMoveDis;
    float _bottomMoveDis;
    
    bool _topHasPlant;
    
    virtual void onEnterTransitionDidFinish();
    
};

#endif /* WaterPipe_hpp */
