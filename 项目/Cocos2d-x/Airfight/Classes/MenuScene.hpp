//
//  MenuScene.hpp
//  Airfight
//
//  Created by 金亮齐 on 2017/7/21.
//
//

#ifndef MenuScene_hpp
#define MenuScene_hpp

#include <iostream>
#include "AudioControlScene.hpp"

// 1. GameMenu类的作用是显示一个菜单场景，让用户选择“开始游戏”或是“游戏设置”。
class GameMenu : public cocos2d::Layer
{
public:
    /**
     * 静态函数，创建Scene场景
     * 注意：在Cocos2d-x中没有Cocos2d-iPhone中的“id”,建议返回类实例的指针
     */
    static cocos2d::Scene* createScene();
    /**
     * init函数，完成初始化操作。
     * 注意：init函数在Cocos2d-x中返回bool值，而不是返回Cocos2d-iPhone中的“id”
     */
    virtual bool init();
    
    /**
     * 使用CREATE_FUNC宏创建当前类的对象，返回的对象将会由自动释放池管理内存的释放
     */
    CREATE_FUNC(GameMenu);
};


#endif /* MenuScene_hpp */
