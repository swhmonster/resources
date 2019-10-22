package ${packageMapper}.write.base;

import java.util.List;
import ${packageModel}.${className};
/**
*  @author ${author}
*/
public interface ${mapperName}BaseWriteMapper {

    <#include "base/insertMapper.ftl">

    <#include "base/updateMapper.ftl">

}