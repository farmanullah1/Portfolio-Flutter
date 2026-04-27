import React from 'react';
import { motion } from 'framer-motion';
import { FaReact, FaNodeJs, FaDocker, FaPython, FaAws, FaLinux, FaGithub } from 'react-icons/fa';
import { SiMongodb, SiExpress, SiTailwindcss, SiTypescript } from 'react-icons/si';
import { TbBrandCSharp } from 'react-icons/tb';
import { BiNetworkChart } from 'react-icons/bi';
import { BsBarChartFill } from 'react-icons/bs';

const MARQUEE = [
  { name: 'C#',           icon: <TbBrandCSharp /> },
  { name: 'ASP.NET Core', icon: <BiNetworkChart /> },
  { name: 'React.js',     icon: <FaReact /> },
  { name: 'Node.js',      icon: <FaNodeJs /> },
  { name: 'MongoDB',      icon: <SiMongodb /> },
  { name: 'Express.js',   icon: <SiExpress /> },
  { name: 'Docker',       icon: <FaDocker /> },
  { name: 'AWS',          icon: <FaAws /> },
  { name: 'Python',       icon: <FaPython /> },
  { name: 'Linux',        icon: <FaLinux /> },
  { name: 'Git & GitHub', icon: <FaGithub /> },
  { name: 'Power BI',     icon: <BsBarChartFill /> },
  { name: 'TypeScript',   icon: <SiTypescript /> },
  { name: 'Tailwind',     icon: <SiTailwindcss /> },
];

// --cat-color is set inline so CSS can use it for the left border, dot, title, hover
const CATS = [
  { title: 'Frontend',          color: '#e040fb', skills: ['React.js','TypeScript','Tailwind CSS','HTML5 / CSS3','Framer Motion'] },
  { title: 'Backend',           color: '#7c3aed', skills: ['Node.js','Express.js','ASP.NET Core','C#','REST APIs'] },
  { title: 'Database & Cloud',  color: '#00e5ff', skills: ['MongoDB','SQL Server','AWS EC2 / EB','Docker','Linux'] },
  { title: 'Tools & Other',     color: '#ffab40', skills: ['Git & GitHub','Power BI','Python','Figma','Postman'] },
];

const Skills = () => (
  <section className="skills" id="skills">
    <motion.h2 initial={{ opacity:0, y:-20 }} whileInView={{ opacity:1, y:0 }} viewport={{ once:true }}>
      Technical Skills
    </motion.h2>

    {/* Infinite marquee */}
    <motion.div
      className="marquee-container"
      initial={{ opacity:0 }} whileInView={{ opacity:1 }} viewport={{ once:true }}
      transition={{ duration:.7 }}
    >
      <div className="marquee-track">
        {[...MARQUEE, ...MARQUEE].map((s, i) => (
          <motion.div className="skill-card-scroll" key={i} whileHover={{ scale:1.12, y:-10 }}>
            <div className="skill-icon-large">{s.icon}</div>
            <p className="skill-name">{s.name}</p>
          </motion.div>
        ))}
      </div>
    </motion.div>

    {/* Category grid */}
    <div className="skill-categories">
      {CATS.map((cat, ci) => (
        <motion.div
          className="skill-category"
          key={ci}
          style={{ '--cat-color': cat.color }}
          initial={{ opacity:0, y:28 }}
          whileInView={{ opacity:1, y:0 }}
          viewport={{ once:true }}
          transition={{ delay:ci*.1, duration:.5 }}
          whileHover={{ y:-6 }}
        >
          <div className="skill-cat-header">
            <span className="skill-cat-dot" />
            <h4>{cat.title}</h4>
          </div>
          <div className="skill-pills">
            {cat.skills.map((s, si) => (
              <motion.span className="skill-pill" key={si} style={{ '--cat-color': cat.color }} whileHover={{ scale:1.08, y:-3 }}>
                {s}
              </motion.span>
            ))}
          </div>
        </motion.div>
      ))}
    </div>
  </section>
);
export default Skills;